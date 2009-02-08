class Injector
  def initialize(bind_module)
    @root_module = bind_module
  end

  def get_instance(clazz)
    @root_module.get_instance(clazz)
  end
end

class ShitBrix  
  def self.create_injector(bind_module)    
    @@injector = Injector.new(bind_module)    
  end

  def self.injector
    @@injector
  end
end

class AbstractModule
  def initialize    
    @bindings = Hash.new
    configure
  end

  def bind(key, &initializer) 
    if @bindings.has_key?(key)
      raise RuntimeError, "Multiply binding for one key not allowed (Errorneous key: '#{key}')"
    else
      @bindings[key] = Proc.new(&initializer)    
    end
  end

  def install(bind_module_class)    
    join(bind_module_class.new)
  end

  def get_instance(clazz)
    initializer = @bindings[clazz]
    if initializer != nil
      @bindings[clazz].call
    else
      raise RuntimeError, "No binding for '#{clazz}'"
    end
  end  

protected
  attr_accessor :bindings  

  def configure
    raise NoMethodError, "AbstractModule should not be instaniated explicitly. Extend it and override configure method."
  end

  def join(bind_module)
    bind_module.bindings.each do |key, initializer|
      bind(key, &initializer)      
    end
  end
end

class Class
  def inject(request)    
    if (@injection_requests == nil) then 
      @injection_requests = Array.new      
    end
  
    @injection_requests << request
  end

  alias __new  new
   
  def new(*args, &block)
    obj = __new(*args, &block)

    if (@injection_requests != nil) then
      @injection_requests.each do |request|         
        obj.instance_variable_set("@#{request}", ShitBrix.injector.get_instance(request))
      end      
    end

    return obj
  end
end