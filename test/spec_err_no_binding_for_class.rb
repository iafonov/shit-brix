require 'lib/shitbrix.rb'

describe ShitBrix do    
  it "should throw exception if there is no binding for injected class" do
    require 'test/samples/test_app_missing_binding.rb'
    lambda { Application.new }.should raise_error(RuntimeError, "No binding for 'action'")
  end
end