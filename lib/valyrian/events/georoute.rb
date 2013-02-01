module Valyrian
class GeoRouteEvent < Valyrian::Default
  MAIN = "GeoRouteGroup"
  TEMPLATE = 'georoute'
  GEOROUTE_ASSOC = ['geo_route_group_id','ani_group_id']

  ASSOC = 'geo_route_group'

  SUBEVENTS = [
    {:type => :object,
     :criteria => Proc.new {|event| event["type"] == "GeoRouteAniXref"},
     :method => :find_association_message
    }
  ]

  def find_association_message(event)
    action = event["action"]
    h = {:anigroup => @assoc['ani_group'], :georoute => @assoc['geo_route_group']}
    message = @subevent.message_for("association.#{action}",h)
    add_sub_event(message) if message
  end
  
end
end
