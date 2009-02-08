require 'shitbrix.rb'

describe ShitBrix do  
  before(:each) do
    ShitBrix.instance_variable_set(:@injector, nil)
  end

  it "should build application and inject dependent service to action" do    
    require 'test/samples/test_app_simple_example.rb'
    app = Application.new
    app.do_real_work.should == "work"
  end

  it "should inject nested dependencies" do
    require 'test/samples/test_app_nested_inject.rb'
    app = Application.new
    app.do_real_work.should == "work"  

    app.dispatcher.class.should == Dispatcher
    app.dispatcher.action.class.should == Action
    app.dispatcher.action.service.class.should == Service
  end

  it "should inject dependencies described(bind) in different nested modules" do
    require 'test/samples/test_app_nested_modules.rb'
    app = Application.new
    app.do_real_work.should == "work"  

    app.dispatcher.class.should == Dispatcher
    app.dispatcher.action.class.should == Action
    app.dispatcher.action.service.class.should == Service
  end
  
  it "should throw exception if there is double binding for class" do
    require 'test/samples/test_app_double_binding.rb'
    lambda { Application.new }.should raise_error RuntimeError, "Multiply binding for one key not allowed (Errorneous key: 'action')"
  end

  it "should throw exception if there is double binding for class in different module" do
    require 'test/samples/test_app_double_binding_in_nested_module.rb'
    lambda { Application.new }.should raise_error RuntimeError, "Multiply binding for one key not allowed (Errorneous key: 'dispatcher')"
  end

  it "should throw exception if there is no binding for injected class" do
    require 'test/samples/test_app_missing_binding.rb'
    lambda { Application.new }.should raise_error RuntimeError, "No binding for 'action'"
  end

  it "should throw exception if user will try to instaniate AbstractModule without extending" do
    require 'test/samples/test_app_abstract_module_instaniate.rb'
    lambda { Application.new }.should raise_error NoMethodError
  end

  it "should throw exception if there is more than one injector created" do
    
  end
end
