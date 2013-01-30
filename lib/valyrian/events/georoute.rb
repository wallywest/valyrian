module Valyrian
class GeoRouteEvent < Valyrian::Default
  MAIN = "GeoRouteGroup"
  TEMPLATE = 'georoute'

  ASSOC = 'geo_route_group'

  SUBEVENTS = [
    {:type => :action,
     :criteria => Proc.new { @assoc.nil?},
     :method => :find_association_message
    }
  ]

  def find_association_message
    h = {:anigroup => @assoc['ani_group'], :georoute => @assoc['geo_route_group']}
    message = @subevent.message_for("association.#{@action}",h)
    add_sub_event(message) if message
  end
  
end
end
