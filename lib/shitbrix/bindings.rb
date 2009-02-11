class ObjectBinding
  def initialize(object)    
    @instance = object
  end

  def get_instance
    @instance
  end
end

class ProcBinding
  def initialize(&initializer)
    @initializer = Proc.new(&initializer) 
  end

  def get_instance
    @initializer.call
  end
end

class ClassBinding
  def initialize(clazz, modifier)
    @class = clazz
    @modifier = modifier   
        
  end

  def get_instance
    if ((@modifier == :singleton) && (@instance == nil))
      @instance = @class.new
    end

    @instance
  end
end

class Binding
  def self.for_block(&initializer)
    ProcBinding.new(&initializer)
  end

  def self.for_class(clazz, modifier=nil)
    if (modifier == nil)    
      ProcBinding.new { clazz.new }        
    else   
      ClassBinding.new(clazz, modifier)
    end
  end

  def self.for_object(object)
    ObjectBinding.new(object)
  end
end