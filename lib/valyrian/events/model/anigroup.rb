module Valyrian::Events
class AniGroupEvent < Valyrian::Events::Default

  MAIN = ["AniGroup"]
  CHILDREN = ["AniMap"]
  TEMPLATE = 'anigroup'

  #add this if want to find identity with association as well
  ASSOC = 'ani_group'

  #subevents to render
  SUBEVENTS = [
    {:type => :action,
     :criteria => Proc.new {|event| CHILDREN.include?(event["type"])},
     :method => :ani_map_message
    }
  ]

  def ani_map_message(event)
    object = event["object"]
    case event["action"]
    when "destroy"
      add_sub_event("AniMap #{object["ani"]} was removed")
    when "create"
      add_sub_event("AniMap #{object["ani"]} was created")
    else
    end
  end

end
end
