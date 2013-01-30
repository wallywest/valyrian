module Valyrian
class AniGroupEvent < Valyrian::Default

  MAIN = "AniGroup"
  CHILDREN = ["AniMap"]
  TEMPLATE = 'anigroup'

  #add this if want to find identity with association as well
  ASSOC = 'ani_group'

  #subevents to render
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

end
end
