module Valyrian::Events
  class ModelMessage
    include Virtus
    
    attribute :template, String
    attribute :main_event, String
    attribute :changed, Array, :default => []
    attribute :sub_events, Array,:default => []
    attribute :identity, String
    attribute :meta, Hash
    attribute :type, String

  end
end
