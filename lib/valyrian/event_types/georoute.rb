module Valyrian
class GeoRouteEvent < Valyrian::Default
  MAIN = "GeoRouteGroup"
  CHILDREN = ["GeoRouteAniXref"]
  TEMPLATE = 'georoute'

  def find_identifier
    super
    find_by_association if @identifier.nil?
  end

  def find_by_association
    set_identity(@assoc["geo_route_group"]) if @assoc
  end


  def find_changes
    @subevent = Subevent.new("georoute")
    if @type == MAIN
      @message.changed << @changed if @changed
    else
      find_association_message if @assoc
    end
  end

  def find_association_message
    h = {:anigroup => @assoc['ani_group'], :georoute => @assoc['geo_route_group']}
    message = @subevent.message_for("association.#{@action}",h)
    add_sub_event(message) if message
  end

  def template
    TEMPLATE
  end
  
end
end
