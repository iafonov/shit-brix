require 'lib/shitbrix.rb'

describe ShitBrix do      
  it "should allow calling new in module configure method" do
    require 'test/samples/test_app_explicit_new_call.rb'
    app = Application.new

    app.action.should_not == nil
    lambda { app.action.perform }.should raise_error(NoMethodError)    

    app.do_real_work.should == "work"
  end
end