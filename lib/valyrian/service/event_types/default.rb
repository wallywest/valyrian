module Valyrian::Service
class Default

  include Valyrian::Service::Discovery
  extend Valyrian::Service::Discovery

  attr_reader :message
  def initialize(controller,events,action)
    @events = events
    @controller = controller
    @caction = action
    @message = {"template" => template, "messages" => {} }

    #set identifier for event type (name,display_name, value)
    #main event is the title message i.e. User updated Company at
    #categorize/group subevents/messages which can be changes/statements
    build_events
    logger.info("Message: #{@message}\n Type: #{self.class}")
  end

  def build_events
    @events.each do |event|

      @type = event["type"]
      @assoc = event["assoc"]
      @object = event["object"]
      @changed = event["changed"]
      @action = event["event"]

      find_identifier if @identifier.nil?
      find_messages
      sub_event.flatten!
    end
  end

  def find_messages
    changed << @changed if @changed
  end

  def find_identifier
    attributes.each do |attr|
      if @type == object_name
        set_identity(@object[attr])
      end
    end
  end


  private

  def changed
    messages["changed"] ||= Set.new
  end

  def sub_event
    messages["subevent"] ||= []
  end

  def add_sub_event(message)
    logger.info("SubEvent Message: #{@message}\n")
    unless sub_event.include?(message)
        sub_event << message
    end
  end

  def messages
    @message["messages"]
  end

  def template
    @controller.singularize
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
   rules[@controller] ||= {}
  end

  def attributes
    #returns attribute associated with identity
    object_rule["object"] ||= []
  end

  def rules
    #yaml file of definitions for identifiers
    Valyrian.rules("default")
  end

  def set_template(t)
    @message["template"] = t
  end
end
end
