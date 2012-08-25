module Valyrian::Service
class PackageEvent
  attr_reader :message

  def initialize(controller,events,action,assoc)
    @events = events
    @controller = controller
    @action = action
    @assoc = assoc
    @message = {"template" => template, "messages" => {}, "identifier" => identifier}

    #set identifier for event type (name,display_name, value)
    #main event is the title message i.e. User updated Company at
    #categorize/group subevents/messages which can be changes/statements

    #@events.each do |event|
      #find_messages(event)
    #end

    #format_message if object_rule
    #find_identifier if object_rule
    logger.info("Message: #{@message}\n Type: #{self.class}")
  end


  private

  def identifier
    @assoc["name"]
  end

  def template
    "package"
  end

  def logger
    Valyrian.logger
  end

end
end
