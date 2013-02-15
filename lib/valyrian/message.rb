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
    attribute :user, String
    attribute :events, Array, :default => []
    attribute :changes, Integer, :default => 0
    attribute :message, Hash, :default => {}

    attr_accessor :message

    def formatted
      event_handler = find_handler_for(controller)

      self.action = pastify(controller,action,event_handler)

      logger.info(event_handler)
      logger.info(attributes)

      begin
        handler = event_handler.new(controller,action,events)
      rescue Exception => e
        raise Valyrian::InvalidMessage
      end

      self.message = handler.message
      self.as_json.except(:events)
    end

  end
end
