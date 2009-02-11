require 'lib/shitbrix.rb'

describe ShitBrix do    
  it "should build example application every one should see first to see DI basics" do
    require 'test/samples/example.rb'
    app = Application.new
    app.do_real_work.should == "work"
  end
end