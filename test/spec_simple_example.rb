require 'lib/shitbrix.rb'

describe ShitBrix do      
  it "should build application and inject dependent service to action" do
    require 'test/samples/test_app_simple_example.rb'
    app = Application.new
    app.do_real_work.should == "work"
  end
end