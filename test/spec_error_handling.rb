require 'lib/shitbrix.rb'

describe ShitBrix do  
  it "should throw exception if there is double binding for class" do
    require 'test/samples/test_app_double_binding.rb'
    lambda { Application.new }.should raise_error(RuntimeError, "Multiply binding for one key not allowed (Errorneous key: 'action')")
  end

  it "should throw exception if there is double binding for class in different module" do
    require 'test/samples/test_app_double_binding_in_nested_module.rb'
    lambda { Application.new }.should raise_error(RuntimeError, "Multiply binding for one key not allowed (Errorneous key: 'dispatcher')")
  end

  it "should throw exception if there is no binding for injected class" do
    require 'test/samples/test_app_missing_binding.rb'
    lambda { Application.new }.should raise_error(RuntimeError, "No binding for 'action'")
  end

  it "should throw exception if user will try to instaniate AbstractModule without extending" do
    require 'test/samples/test_app_abstract_module_instaniate.rb'
    lambda { Application.new }.should raise_error(NoMethodError)
  end

  it "should throw exception if there is more than one injector created" do    
    # it will ...
  end

  it "should throw exception if injector.get_instance called explicitly more than one time (it is bad style)" do
    # it will ...
  end
end
