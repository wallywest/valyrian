module Valyrian::Service
class Default
  attr_reader :message
  def initialize(controller,events,action)
    @events = events
    @controller = controller
    @action = action
    @message = {"template" => template, "messages" => {}}

    #set identifier for event type (name,display_name, value)
    #main event is the title message i.e. User updated Company at
    #categorize/group subevents/messages which can be changes/statements

    @events.each do |event|
      find_identifier(event) if @identifier.nil?
      #find_messages(event)
    end

    #format_message if object_rule
    #find_identifier if object_rule
    logger.info("Message: #{@message}\n Type: #{self.class}")
  end

  def find_identifier(event)
    type = event["type"]
    attributes.each do |attr|
      if type == object_name
        set_identity(event["object"][attr])
      end
    end
  end


  private

  def template
    @controller.classify.downcase
  end

  def set_identity(value)
    @identifier = value
    @message.merge!({"identity" => value})
  end

  def main_event
    @message["messages"]
  end

  def logger
    Valyrian.logger
  end

  def object_name
    object_rule["model"] ||= @controller.classify
  end

  def object_rule
   rules[@controller]
  end

  def attributes
    #returns attribute associated with identity
    object_rule["object"]
  end

  def rules
    #yaml file of definitions for identifiers
    Valyrian.rules("default")
  end

end
end
