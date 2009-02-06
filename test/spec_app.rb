require 'test/test_app.rb'

describe MegaSuperApplication do
  it "should build mega application and inject ConcreteService to it" do    
    app = MegaSuperApplication.new
    app.do_real_work.should == "concrete"
  end

  after(:all) do

  end
end
