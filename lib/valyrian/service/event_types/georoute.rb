module Valyrian::Service
class GeoRouteEvent < Valyrian::Service::Default
  MAIN = "GeoRouteGroup"
  CHILDREN = ["GeoRouteAniXref"]

  def find_identifier(event)
    super
    find_by_association(event) if @identifier.nil?
  end

  def find_messages(event)
    if event["type"] == MAIN
      changed << event["changed"] unless event["changed"].nil?
    else
      find_association_message(event)
    end
  end

  def find_by_association(event)
    assoc = event["assoc"]
    set_identity(assoc["geo_route_group"]) if assoc
  end

  def find_association_message(event)
    assoc = event["assoc"]
    return if assoc.nil?
    case event["event"]
    when 'create'
      message = "AniGroup #{assoc['ani_group']} is assigned to GeoRoute #{assoc['geo_route_group']}"
    when 'update'
      message = "AniGroup #{assoc['ani_group']} is assigned to GeoRoute #{assoc['geo_route_group']}"
    when 'destroy'
      message = "AniGroup #{assoc['ani_group']} is removed from GeoRoute #{assoc['geo_route_group']}"
    else
      puts "wtf"
    end
    sub_event << message
  end

  def template
    "georoute"
  end
  
end
end
