module Valyrian
class AniGroupEvent < Valyrian::Default

  MAIN = "AniGroup"
  CHILDREN = ["AniMap"]
  TEMPLATE = 'anigroup'

  ASSOC_FINDER = 'ani_group'

  SUBEVENTS = [
    {:type => :action,
     :criteria => Proc.new {|x| x == "destroy"},
     :message => Proc.new{|ani| "AniMaps #{v.join(",")} were removed"},
    },
    {:type => :action,
     :criteria => Proc.new {|x| x == "create"},
     :message => Proc.new{|ani| "AniMaps #{v.join(",")} were created"},
    }
  ]

  def default_values
    @anis ||= {"added" => [], "removed" => []}
    super
    write_ani_messages
  end

  def find_identifier
    super
    find_by_association if @identifier.nil?
  end

  def find_changes
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
      message = "AniMaps #{v.join(",")} were #{k}"
      add_sub_event(message) unless v.empty?
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
