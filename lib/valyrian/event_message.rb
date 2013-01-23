module Valyrian
  class EventMessage
    include Virtus
    
    attribute :template, String
    attribute :main_event, String
    attribute :changed, Array
    attribute :sub_events, Array
    attribute :identity, String
    attribute :meta, Hash

  end
end
