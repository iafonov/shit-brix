class Binder
  def initialize(parent_module, key)
    @parent_module = parent_module
    @key = key
  end
end

class ClassBinder < Binder
  def as_singleton
    
  end

  def as_eager_singleton
    @parent_module.bindings[@key] = @parent_module.bindings[@key].new
  end
end

class CommonBinder < Binder  
  def to(*args, &initializer)    
    if block_given?
      @parent_module.bindings[@key] = Proc.new(&initializer)    
    else
      @parent_module.bindings[@key] = args[0]

      if args[0].instance_of? Class      
        return ClassBinder.new(@parent_module, @key)
      end
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
      CommonBinder.new(self, key)
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
    elsif initializer != nil
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