require 'lib/shitbrix.rb'

describe ShitBrix do        
  it "should bind dependencies given as class and instaniate them" do
    require 'test/samples/test_app_binding_to_class.rb'
    app = Application.new
    app.do_real_work.should == "work"
  end
end