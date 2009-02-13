require 'lib/shitbrix.rb'

describe ShitBrix do
  it "should throw exception if user will try to instaniate AbstractModule without extending" do
    require 'test/samples/test_app_abstract_module_instaniate.rb'
    lambda { Application.new }.should raise_error(NoMethodError)
  end  
end
