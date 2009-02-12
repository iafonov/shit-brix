class Class
  attr_accessor :injection_requests

  def inject(request)    
    if (@injection_requests == nil) then 
      @injection_requests = Array.new      
    end
  
    @injection_requests << request
  end

  alias __new  new
   
  def new(*args, &block)
    obj = __new(*args, &block)

    if (ShitBrix.ready? && @injection_requests != nil) then
      @injection_requests.each do |request|         
        obj.instance_variable_set("@#{request}", ShitBrix.get_instance(request))
      end      
    end

    return obj
  end
end