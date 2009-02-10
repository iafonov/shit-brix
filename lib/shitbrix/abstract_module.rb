class Bind  
  def initialize(parent_module, key)
    @parent_module = parent_module
    @key = key
  end

  def to(*args, &initializer)    
    if block_given?
      @parent_module.bindings[@key] = Proc.new(&initializer)    
    else       
      @parent_module.bindings[@key] = args[0]
    end
  end
end

class AbstractModule
  def initialize    
    @bindings = Hash.new
    configure
  end

  def bind(key) 
    if @bindings.has_key?(key)
      raise RuntimeError, "Multiply binding for one key not allowed (Errorneous key: '#{key}')"
    else      
      Bind.new(self, key)
    end
  end  

  def install(bind_module_class)    
    join(bind_module_class.new)
  end

  def get_instance(clazz)
    initializer = @bindings[clazz]

    if initializer.instance_of? Proc
      initializer.call
    elsif initializer.instance_of? Class      
      initializer.new
    elsif initializer.kind_of? Action
      initializer
    else    
      raise RuntimeError, "No binding for '#{clazz}'"      
    end
  end  
  
  attr_accessor :bindings # for recursive dependency search

protected    
  def configure
    raise NoMethodError, "AbstractModule should not be instaniated explicitly. Extend it and override configure method."
  end
  
  def join(bind_module)
    bind_module.bindings.each do |key, initializer|
      bind(key).to initializer
    end
  end
end