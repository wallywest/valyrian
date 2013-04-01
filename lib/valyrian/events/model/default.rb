module Valyrian::Events
  class Default
    include EventUtils

    attr_accessor :message,:action,:controller

    def initialize(controller,action,events)

      @controller,@action,@events = controller,action,events
      @message = ModelMessage.new(:type => self.class.to_s.gsub(/Valyrian::/,''))
      @subevent = Subevent.new(@controller.singularize)

      set_template(template)
      if matchingRule?
        parse_rule
      else
        parse_events
      end
    end

    def parse_events
      @events.each do |event|
        @type = event["type"]
        @assoc = event["assoc"] || event["meta"]
        @object = event["object"]

        find_identifier if missing_identity?
        parse_event(event)
      end
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
      identity = find_from_object(@object,@type) || find_from_assoc(@assoc)
      set_identity(identity)
    end

    def parse_event(event)
      apply_sub_events(event) if has_subevents?
      add_change_message(event["changed"]) if has_main_type_changed?(event["changed"])
    end

    def parse_rule
      rule_definitions.each do |rule|
        criteria = rule[:criteria]
        method = rule[:method]
        self.send(method)
      end
    end

    def apply_sub_events(event)
      definitions.each do |rule|
        criteria = rule[:criteria]
        if rule.has_key?(:method)
          method = rule[:method]
          self.send(method,event) if criteria.call(event)
        elsif rule.has_key?(:message)
          message = rule[:message].call(event["object"]) if criteria.call(event)
          add_sub_event(message) if message
        end
      end
    end

  end
end


