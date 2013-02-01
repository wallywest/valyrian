module Valyrian
class AniGroupEvent < Valyrian::Default

  MAIN = ["AniGroup"]
  CHILDREN = ["AniMap"]
  TEMPLATE = 'anigroup'

  #add this if want to find identity with association as well
  ASSOC = 'ani_group'

  #subevents to render
  SUBEVENTS = [
    {:type => :action,
     :criteria => Proc.new {|event| event["action"] == "destroy"},
     :message => Proc.new{|object| "AniMap #{object["ani"]} was removed"}
    },
    {:type => :action,
     :criteria => Proc.new {|event| event["action"] == "create"},
     :message => Proc.new{|object| "AniMap #{object["ani"]} was created"}
    }
  ]

end
end
