class Service
  def go()
    "work"
  end
end

class Action
  inject :service
  attr_accessor :service

  def perform()
    @service.go
  end
end

class Dispatcher
  inject :action
  attr_accessor :action

  def perform
    @action.perform
  end
end

class ServiceModule < AbstractModule
  def configure()    
    bind(:service) { Service.new }    
  end
end

class ActionModule < AbstractModule
  def configure()        
    bind(:action) { Action.new }    
  end
end

class ApplicationModule < AbstractModule
  def configure()    
    install(ServiceModule)
    install(ActionModule)
    bind(:dispatcher) { Dispatcher.new }
  end
end

class Application
  attr_accessor :dispatcher

  def initialize
    ShitBrix.create_injector(ApplicationModule.new)    
    @dispatcher = ShitBrix.injector.get_instance(:dispatcher)
  end

  def do_real_work    
    @dispatcher.perform
  end
end