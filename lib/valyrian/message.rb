module Valyrian
  class Message
    include Rules
    include Utils
 
    include Virtus

    attribute :ip, String
    attribute :app_id, Integer
    attribute :_id, String
    attribute :controller, String
    attribute :action, String
    attribute :ts, String
    attribute :events, Array, :default => []
    attribute :changes, Integer, :default => 0
    attribute :message, Hash, :default => {}

    attr_accessor :message


    def format
      self.action = pastify(action)

      event_handler = find_handler_for(controller)

      logger.info(event_handler)
      logger.info(attributes)

      handler = event_handler.new(controller,action,events)
      
      #message => {:main_event => "", :sub_events => "", :changed => "", :template =>"")

      ##@audit.attributes.merge!(handle.new(dup).message)
      self.message = handler.message
    end

  end
end
