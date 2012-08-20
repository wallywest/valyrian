module Valyrian::Service
  class Message
    attr_accessor :m

    def self.format(event)
      e = new(event)
      e.m
    end

    def initialize(event)

      @m = event.attributes.dup

      events = @m.delete("events")
      controller = @m.delete("controller")
      action = @m.delete("action")

      pastify(action)

      handler = handler_for(controller)

      #logger.info("#{controller} with handler #{handler}")
      
      h = handler.new(events,controller)
    end
    
    def handler_for(controller)
      event_rules.each do |rule|
        rule.each_pair do |key,value|
          out = key.detect {|reg| reg =~ controller}
          return ::Valyrian::Service.const_get(value) unless out.nil?
        end
      end
      return ::Valyrian::Service.const_get(:Default)
    end

    def logger
      Valyrian.logger
    end

    def action_rules
      [
        [/quick_edit.*$/,'updated'],
        [/copy_multiple/,'copied multiple'],
        [/destroy_multiple/,'destroyed multiple'],
        [/e$/,'ed'],
        ["copy","copied"],
        ["destroy","destroyed"]
      ]
    end

    def event_rules
      [
        {[/company.*$/] => :CompanyEvent},
        {[/ani_groups/,/geo_route_groups/] => :GeoRouteEvent},
        {[/preroute.*$/] => :PreRouteEvent},
        {[/dlis/] => :DliEvent },
        {[/frontend_numbers/] => :FrontEndNumberEvent},
        {[/activations/] => :ActivationEvent},
        {[/backend_number/] => :VlabelMapEvent},
        {[/packages/,/time_segments/,/profiles/,/routings/,/routing_destinations/] => :PackageEvent},
        {[/groups/,/operations/] => :GroupOpEvent}
      ]
    end

    def msg_rules
      Valyrian.rules
    end

    def pastify(action)
      result = action.to_s.dup
      action_rules.each { |(rule,replacement)| break if result.gsub!(rule,replacement)}
      @m["action"] = result
    end

  end
end
