require 'lib/shitbrix.rb'

describe ShitBrix do  
  it "should throw exception if there is double binding for class in different module" do
    require 'test/samples/test_app_double_binding_in_nested_module.rb'
    lambda { Application.new }.should raise_error(RuntimeError, "Multiply binding for one key not allowed (Errorneous key: 'dispatcher')")
  end
end