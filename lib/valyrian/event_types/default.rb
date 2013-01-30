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
      @assoc = event["assoc"] || event["meta"]
      @object = event["object"] || event["payload"]
      @changed = event["changed"]
      @action = event["event"] || event["action"]

      find_identifier if @identifier.nil?
      find_changes
    end

    self.sub_events.flatten!
    set_template(template)
  end

  def find_identifier
    attributes.each do |attr|
      if @type == object_name
        set_identity(@object[attr])
      end
    end
  end

end
end
