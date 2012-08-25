module Valyrian::Service
class StaticEvent
  attr_reader :message

  def initialize(controller,events,action)
    
    @controller = controller
    @message = {"template" => template}

    #format_message if object_rule
    #find_identifier if object_rule
    logger.info("Message: #{@message}\n Type: #{self.class}")
  end


  private

  def template
    @controller.camelize.downcase
  end

  def logger
    Valyrian.logger
  end

end
end
