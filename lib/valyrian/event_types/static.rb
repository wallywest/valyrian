module Valyrian
class StaticEvent
  attr_reader :message

  def initialize(controller,action,events)
    @controller = controller
    @message = EventMessage.new(:template => template)
  end

  private

  def template
    @controller.camelize.downcase
  end

end
end
