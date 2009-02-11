class Class
  def inject(request)    
    if (@injection_requests == nil) then 
      @injection_requests = Array.new      
    end
  
    @injection_requests << request
  end

  alias __new  new
   
  def new(*args, &block)
    obj = __new(*args, &block)

    if ((@injection_requests != nil) && (ShitBrix.injector != nil)) then
      @injection_requests.each do |request|         
        obj.instance_variable_set("@#{request}", ShitBrix.injector.get_instance(request))
      end      
    end

    return obj
  end
end