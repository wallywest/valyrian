module Valyrian::Events
  class StatusEvent
    include EventUtils
    TEMPLATE = 'status'

    attr_accessor :message

    def initialize(event)
      @message = StatusMessage.new(:type => event["type"], :action => event["action"], :template => "status")
    end

  end
end


