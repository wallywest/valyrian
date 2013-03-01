module Valyrian
  class StaticEvent
    include EventUtils

    attr_accessor :message

    def initialize(controller,action,events)
      @controller,@action,@events = controller,action,events
      @message = EventMessage.new(:type => self.class.to_s.gsub(/Valyrian::/,''))
      @subevent = Subevent.new(@controller.singularize)

      case @controller
      when "cache_refresh"
        set_template('cache_refresh')
      when "Session"
        set_template('session')
      end
      set_identity("static")
    end
  end
end


