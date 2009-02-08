require 'shitbrix.rb'

describe ShitBrix do  
  it "should build mega super application and inject concrete service" do    
    require 'test/samples/test_app_simple_example.rb'
    app = MegaSuperApplication.new
    app.do_real_work.should == "concrete"
  end

  it "should inject nested dependencies" do
    require 'test/samples/test_app_nested_inject.rb'
    app = Application.new
    app.do_real_work.should == "work"  

    app.dispatcher.class.should == Dispatcher
    app.dispatcher.action.class.should == Action
    app.dispatcher.action.service.class.should == Service
  end

  it "should throw exception if there is no binding for injected class" do
    require 'test/samples/test_app_missing_binding.rb'
    lambda { Application.new }.should raise_error RuntimeError, "No binding for 'action'"
  end
end
