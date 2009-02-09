class AbstractModule
  def initialize    
    @bindings = Hash.new
    configure
  end

  def bind(key) 
    if @bindings.has_key?(key)
      raise RuntimeError, "Multiply binding for one key not allowed (Errorneous key: '#{key}')"
    else
      @key = key
      self
    end
  end

  def to(&initializer)    
    @bindings[@key] = Proc.new(&initializer)    
  end

  def to_class(clazz)
    @bindings[@key] = clazz
  end

  def install(bind_module_class)    
    join(bind_module_class.new)
  end

  def get_instance(clazz)
    initializer = @bindings[clazz]

    if initializer.instance_of? Proc
      initializer.call
    else if initializer.instance_of? Class      
        initializer.new
      else    
        raise RuntimeError, "No binding for '#{clazz}'"
      end
    end
  end  

protected
  attr_accessor :bindings  

  def configure
    raise NoMethodError, "AbstractModule should not be instaniated explicitly. Extend it and override configure method."
  end

  def join(bind_module)
    bind_module.bindings.each do |key, initializer|
      bind(key).to &initializer
    end
  end
end