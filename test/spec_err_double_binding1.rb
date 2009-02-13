require 'lib/shitbrix.rb'

describe ShitBrix do  
  it "should throw exception if there is double binding for class" do
    require 'test/samples/test_app_double_binding.rb'
    lambda { Application.new }.should raise_error(RuntimeError, "Multiply binding for one key not allowed (Errorneous key: 'action')")
  end
end