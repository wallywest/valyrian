module Valyrian::Service
class VlabelMapEvent < Valyrian::Service::Default

  def find_by_association(event)
    assoc = event["assoc"]
    set_identity(assoc["group"]) if assoc
  end

  def template
    "vlabelmap"
  end

end
end
