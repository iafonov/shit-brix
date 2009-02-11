class Binder
  def initialize(parent_module, key)
    @parent_module = parent_module
    @key = key
  end

  def to(*args, &initializer)
    if block_given?
      @parent_module.bindings[@key] = Binding.for_block(&initializer)
    else      
      if args[0].instance_of? Class
        @parent_module.bindings[@key] = Binding.for_class(args[0])
        return ClassBinder.new(@parent_module, @key, args[0])
      else
        @parent_module.bindings[@key] = Binding.for_object(args[0])
      end
    end
  end
end

class ClassBinder
  def initialize(parent_module, key, clazz)
    @parent_module = parent_module
    @key = key
    @class = clazz
  end

  def as_singleton
    @parent_module.bindings[@key] = Binding.for_class(@class, :singleton)
  end
 
  def as_eager_singleton
    @parent_module.bindings[@key] = Binding.for_class(@class, :eager_singleton)
  end
end
