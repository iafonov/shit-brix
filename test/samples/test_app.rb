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
  inject :concrete_service  

  def perform    
    @concrete_service.go
  end
end

class ApplicationModule < AbstractModule
  def configure()    
    bind(:concrete_service) { ConcreteService.new }
  end
end

class MegaSuperApplication  
  def initialize
    ShitBrix.create_injector(ApplicationModule.new)
    
    @client = ClientShit.new
  end

  def do_real_work    
    @client.perform
  end
end