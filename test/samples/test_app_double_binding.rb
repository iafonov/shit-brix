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
    bind(:service) { Service.new }
    bind(:action) { Action.new }   
    bind(:action) { Action.new }   
  end
end

class Application
  def initialize
    ShitBrix.create_injector(ApplicationModule.new)
    
    @action = ShitBrix.injector.get_instance(:action)
  end

  def do_real_work    
    @action.perform
  end
end