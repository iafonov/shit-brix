class Injector
  def initialize(bind_module)
    @root_module = bind_module
  end

  def get_instance(clazz)
    @root_module.get_instance(clazz)
  end
end