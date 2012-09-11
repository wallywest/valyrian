module Valyrian::Service
class PreRouteEvent < Valyrian::Service::Default

  TEMPLATE = 'preroute'

  def find_identifier
  end

  def find_by_association
    set_identity(@assoc["group"]) if @assoc
  end

  def template
    TEMPLATE
  end

end
end
