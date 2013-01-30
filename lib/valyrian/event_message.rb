module Valyrian
  class EventMessage
    include Virtus
    
    attribute :template, String
    attribute :main_event, String
    attribute :changed, Array
    attribute :sub_events, Array
    attribute :identity, String
    attribute :meta, Hash
    attribute :type, String

  end
end
