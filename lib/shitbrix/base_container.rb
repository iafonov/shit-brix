class ShitBrix      
  def self.create_injector(bind_module)    
    @@injector = Injector.new(bind_module)    
  end

  def self.injector
    @@injector
  end
end