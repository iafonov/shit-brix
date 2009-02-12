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
    bind(:service).to(Service).as_singleton
    bind(:action).to(Action).as_eager_singleton
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
end