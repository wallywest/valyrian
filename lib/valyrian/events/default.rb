module Valyrian
  class Default
    include Valyrian::Utils
    attr_reader :message

    def initialize(controller,action,events)
      @controller,@action,@events = controller,action,events
      @message = EventMessage.new(:type => self.class.to_s.gsub(/Valyrian::/,''))
      @subevent = Subevent.new(@controller.singularize)

      set_template(template)
      parse_events
    end

    def parse_events
      @events.each do |event|
        @type = event["type"]
        @assoc = event["assoc"] || event["meta"]
        @object = event["object"]

        find_identifier if missing_identity?
        parse_event(event)
      end

      #find_identity
      #find_subevents
    end
      
    def template
      if has_const?("TEMPLATE")
        template = self.class.const_get("TEMPLATE")
      else
        template = @controller.singularize
      end
      template
    end

    def find_identifier
      if has_const?("IDENTITY")
        identity = self.class.const_get("IDENTITY")
      else
        identity = find_from_object(@object,@type) || find_from_assoc(@assoc)
      end
      set_identity(identity)
    end

    def parse_event(event)
      #check_for_subevent
      #check_for_changes
      add_change_message(event["changed"]) if has_main_type_changed?(event["changed"])
    end

  end
end


