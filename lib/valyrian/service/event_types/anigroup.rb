module Valyrian::Service
class AniGroupEvent < Valyrian::Service::Default

  MAIN = "AniGroup"
  CHILDREN = ["AniMap"]

  def build_events
    @anis ||= {"added" => [], "removed" => []}
    super
    write_ani_messages
  end

  def find_identifier(event)
    super
    find_by_association(event) if @identifier.nil?
  end

  def find_messages(event)
    if event["type"] == MAIN
      changed << event["changed"] unless event["changed"].nil?
    else
      group_message_events(event)
    end
  end

  def find_by_association(event)
    assoc = event["assoc"]
    set_identity(assoc["ani_group"]) if assoc
  end

  def group_message_events(event)
    case event["event"]
    when "destroy"
      destroyed_anis << event["object"]["ani"]
    when "create"
      created_anis << event["object"]["ani"]
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
    "anigroup"
  end

end
end
