require 'shitbrix.rb'

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