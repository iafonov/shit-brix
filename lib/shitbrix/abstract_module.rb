class AbstractModule
  def initialize    
    @bindings = Hash.new
    configure
  end

  def bind(key) 
    if @bindings.has_key?(key)
      raise RuntimeError, "Multiply binding for one key not allowed (Errorneous key: '#{key}')"
    else      
      Binder.new(self, key)
    end
  end  

  def install(bind_module_class)    
    join(bind_module_class.new)
  end

  def get_instance(clazz)
    if @bindings.has_key? clazz
      @bindings[clazz].get_instance
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
    bind_module.bindings.each do |key, binding|
      @bindings[key] = binding
    end
  end
end