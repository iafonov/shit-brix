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
    @objects = Hash.new
    configure
  end  

  def bind(key, &initializer) 
    @objects[key] = Proc.new(&initializer)    
  end

  def get_instance(clazz)
    @objects[clazz].call
  end
end

class Class
  def inject(variable)    
    if (@injection_requests == nil) then 
      @injection_requests = Array.new      
    end
  
    @injection_requests << variable
  end

  alias __new  new
   
  def new(*args)     
    obj = __new(*args)    

    if (@injection_requests != nil) then      
      @injection_requests.each do |request|         
        obj.instance_variable_set("@#{request}", ShitBrix.injector.get_instance(request))
      end      
    end

    return obj
  end
end