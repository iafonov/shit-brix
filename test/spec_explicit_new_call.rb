require 'lib/shitbrix.rb'

describe ShitBrix do      
  it "should allow calling new in module configure method" do
    require 'test/samples/test_app_explicit_new_call.rb'
    app = Application.new
    app.create_action.should != nil
    app.create_action.service.should == nil

    app.do_real_work.should == "work"
  end
end