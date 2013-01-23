module Valyrian
class Default

  include Valyrian::Utils
  include Valyrian::Discovery
  extend Valyrian::Discovery

  attr_reader :message, :raw_events

  def initialize(controller,action,events)

    @raw_events = events
    @controller = controller
    @caction = action

    @message = EventMessage.new

    #set identifier for event type (name,display_name, value)
    #main event is the title message i.e. User updated Company at
    #categorize/group subevents/messages which can be changes/statements
    
    default_values
    logger.info("Message: #{@message}\n Type: #{self.class}")
  end

  def default_values
    @raw_events.each do |event|

      @type = event["type"]
      @assoc = event["assoc"]
      @object = event["object"] || event["payload"]
      @changed = event["changed"]
      @action = event["event"]

      find_identifier if @identifier.nil?
      find_changes
      set_template(template || @controller.singularize)

      self.sub_events.flatten!
    end
  end

  def find_changes
    @message.changed << @changed if @changed
  end

  def find_identifier
    attributes.each do |attr|
      if @type == object_name
        set_identity(@object[attr])
      end
    end
  end


  def changed
    @message.changed
  end

  def sub_events
    @message.sub_events
  end

  def add_meta(h)
    @message.meta = h
  end

  def add_sub_event(message)
    logger.info("SubEvent Message: #{@message}\n")
    unless self.sub_events.include?(message)
        @message.sub_events << message
    end
  end

  def set_identity(value)
    @identifier = value
    @message.identity = value
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
    Valyrian.rules
  end

  def set_template(t)
    @message.template = t
  end
end
end
