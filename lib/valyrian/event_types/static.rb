module Valyrian
class StaticEvent
  attr_reader :message

  def initialize(controller,action,events)
    
    @controller = controller
    @message = EventMessage.new(:template => template)

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
