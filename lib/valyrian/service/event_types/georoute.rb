module Valyrian::Service
class GeoRouteEvent < Valyrian::Service::Default
  MAIN = "GeoRouteGroup"
  CHILDREN = ["GeoRouteAniXref"]
  TEMPLATE = 'georoute'

  def find_identifier
    super
    find_by_association if @identifier.nil?
  end

  def find_messages
    if @type == MAIN
      changed << @changed if @changed
    else
      find_association_message
    end
  end

  def find_by_association
    set_identity(@assoc["geo_route_group"]) if @assoc
  end

  def find_association_message
    return if @assoc.nil?
    case @action
    when 'create'
      message = "AniGroup #{@assoc['ani_group']} is assigned to GeoRoute #{@assoc['geo_route_group']}"
    when 'update'
      message = "AniGroup #{@assoc['ani_group']} is assigned to GeoRoute #{@assoc['geo_route_group']}"
    when 'destroy'
      message = "AniGroup #{@assoc['ani_group']} is removed from GeoRoute #{@assoc['geo_route_group']}"
    else
      puts "wtf"
    end
    sub_event << message
  end

  def template
    TEMPLATE
  end
  
end
end
