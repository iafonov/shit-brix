class Service
  def go()
    "work"
  end
end

class Action
  inject :service  

  def perform()
    @service.go
  end
end

class ApplicationModule < AbstractModule
  def configure()    
    bind(:service).to { Service.new }

    action = Action.new
    bind(:explicit_action).to(action)

    bind(:action).to(Action).as_singleton
  end
end

class Application
  def initialize
    ShitBrix.init(ApplicationModule.new)    
    @action = ShitBrix.get_instance(:action)
  end

  def do_real_work    
    @action.perform
  end

  def action
    ShitBrix.get_instance(:explicit_action)
  end
end