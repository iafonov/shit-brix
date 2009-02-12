class ShitBrix      
  @@instance = nil  

  attr_accessor :root_module

  def self.init(bind_module)  
    @@instance = ShitBrix.new(bind_module)      
  end

  def self.ready?
    @@instance != nil
  end

  def self.get_instance(clazz)
    @@instance.root_module.get_instance(clazz)
  end  
private  
  def initialize(bind_module)
    @root_module = bind_module
  end
end