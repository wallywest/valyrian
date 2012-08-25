module Valyrian::Service
class FrontEndNumberEvent < Valyrian::Service::Default 
  #checkforupdate_alls

  def find_identifier(event)
    #super
    #find_by_association(event) if @identifier.nil?
  end

  def find_by_association(event)
    assoc = event["assoc"]
    set_identity(assoc["group"]) if assoc
  end

  def template
    "frontendnumber"
  end

end
end
