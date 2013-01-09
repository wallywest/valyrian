module Valyrian
class AniGroupEvent < Valyrian::Default

  MAIN = "AniGroup"
  CHILDREN = ["AniMap"]
  TEMPLATE = 'anigroup'

  def build_events
    @anis ||= {"added" => [], "removed" => []}
    super
    write_ani_messages
  end

  def find_identifier
    super
    find_by_association if @identifier.nil?
  end

  def find_messages
    if @type == MAIN
      changed << @changed if @changed
    else
      group_message_events
    end
  end

  def find_by_association
    set_identity(@assoc["ani_group"]) if @assoc
  end

  def group_message_events
    case @action
    when "destroy"
      destroyed_anis << @object["ani"]
    when "create"
      created_anis << @object["ani"]
    else
      puts "BOMPB"
    end
  end

  def write_ani_messages
    @anis.each do |k,v|
      sub_event << "AniMaps #{v.join(",")} were #{k}" unless v.empty?
    end
  end

  private

  def created_anis
    @anis["added"]
  end

  def destroyed_anis
    @anis["removed"]
  end

  def template
    TEMPLATE
  end

end
end
