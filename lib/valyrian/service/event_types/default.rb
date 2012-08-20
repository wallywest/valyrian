module Valyrian::Service
class Default
  attr_reader :message
  def initialize(events,controller)
    @events = events
    @controller = controller
    #logger.info(events)
    @message = {"template" => "#{controller.classify}", "main" => {}}

    format_message if object_rule
    logger.info("Message: #{@message}")
  end

  def format_message
    attributes.each do |attr|
      h = value_from_event(attr)
      main_event.merge!({attr => h}) if h
    end
  end


  private

  def value_from_event(attr)
    @events.each do |e|
      if e["type"] == object_name
        return e["object"][attr]
      end
    end
    return nil
  end

  def main_event
    @message["main"]
  end

  def logger
    Valyrian.logger
  end

  def object_name
    object_rule["name"] ||= @controller.classify
  end

  def object_rule
   rules[@controller]
  end

  def attributes
    object_rule["object"]
  end

  def rules
    Valyrian.rules("default")
  end

  def has_subevents?
  end

end
end
