module Valyrian::Events
class LocationEvent < Valyrian::Events::Default

  MAIN = ["Destination"]
  TEMPLATE = 'location'

  #add this if want to find identity with association as well
  #ASSOC = 'ani_group'

  #subevents to render
  SUBEVENTS = []

end
end
