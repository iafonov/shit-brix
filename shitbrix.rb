class Injector
  def initialize(bind_module)
    @root_module = bind_module
  end

  def get_instance(clazz)
    @root_module.get_instance(clazz)
  end
end

class ShitBrix # shit
  def self.create_injector(bind_module)
    Injector.new(bind_module)
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