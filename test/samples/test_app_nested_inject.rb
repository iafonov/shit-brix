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

class ApplicationModule < AbstractModule
  def configure()    
    bind(:service).to { Service.new }
    bind(:action).to { Action.new }
    bind(:dispatcher).to { Dispatcher.new }
  end
end

class Application
  attr_accessor :dispatcher

  def initialize
    ShitBrix.init(ApplicationModule.new)    
    @dispatcher = ShitBrix.get_instance(:dispatcher)    
  end

  def do_real_work        
    @dispatcher.perform
  end
end