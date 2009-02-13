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
    instance = @class.__new
    
    if (@class.injection_requests != nil)
      @class.injection_requests.each do |request|         
        instance.instance_variable_set("@#{request}", @parent_module.get_instance(request))
      end
    end

    @parent_module.bindings[@key] = Binding.for_object(instance)
  end
end
