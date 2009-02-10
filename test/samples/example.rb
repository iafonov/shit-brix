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

class NestedModule < AbstractModule
  def configure()    
    logger = Logger.new
    bind(:logger).to { logger }    
    bind(:action).to { Action.new }   
  end
end

# In implementatinos of AbstractModule you should configure your dependencies, and bind them
# to initializers
class ApplicationModule < AbstractModule
  def configure()
    # By calling the install method and passing another AbstractModule implementation you can divide
    # configuration to several classes to avoid big and messy configure methods
    install(NestedModule)
    
    # You can bind dependencies to blocks that instanite them, ShitBrix uses lazy initialization, so 
    # this block will be called when root class is instanited, and result of its execution will be inject to
    # target class
    bind(:service).to { Service.new }

    # You can bind dependencies to classes, class constructor will be called on injection
    bind(:action).to(Action)

    # You can bind dependencies directly to objects and they will be directly injected to correct place
    bind(:object).to()
  end
end

class Application
  def initialize
    # In the root initialize method of your application you should create injector and
    # pass AbstractModule implementation to it. Here you configure container
    ShitBrix.create_injector(ApplicationModule.new)    

    # You should have only one explicit call of ShitBrix.injector.get_instance in your
    # application. You should explicitly instantiate only root component of your application
    # and all dependencies will be injected to it hierarchically
    @action = ShitBrix.injector.get_instance(:action)
  end

  def do_real_work    
    @action.perform
  end
end