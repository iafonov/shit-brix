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

class ConcreteService
  def go
    "concrete"
  end
end

class FakeConcreteService
  def go
    "fake"
  end
end

class ClientShit
  
  def initialize(service)
    @service = service
  end

  def perform
    @service.go
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

class ApplicationModule < AbstractModule
  def configure()    
    bind(:concrete_service) { ConcreteService.new }
  end
end

class MegaSuperApplication

  def initialize
    injector = ShitBrix.create_injector(ApplicationModule.new)

    service = injector.get_instance(:concrete_service)
    @client = ClientShit.new(service)
  end

  def do_real_work
    @client.perform
  end

end