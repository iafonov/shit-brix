require 'test/test_app.rb'

describe ShitBrix do
  it "should build mega super application and inject concrete service" do    
    app = MegaSuperApplication.new
    app.do_real_work.should == "concrete"
  end

  after(:all) do

  end
end
