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
    bind(:action).to { Action.new }   
  end
end

class Application
  def initialize
    # In the root initialize method of your application you should create injector
    ShitBrix.create_injector(ApplicationModule.new)    
    # 
    @action = ShitBrix.injector.get_instance(:action)
  end

  def do_real_work    
    @action.perform
  end
end