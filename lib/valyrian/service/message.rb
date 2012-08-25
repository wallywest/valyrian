module Valyrian::Service
  class Message

    def self.format(event)
      e = new(event)
      e.message
    end

    def initialize(event)

      @m = event.attributes.dup

      events = @m.delete("events")
      controller = @m.delete("controller")
      action = @m.delete("action")
      assoc = @m.delete("assoc") || @m.delete("m")

      logger.info(@m["_id"])
      pastify(action)

      handle,value = handler_for(controller)
      if value == :PackageEvent
        mes = handle.new(controller,events,action,assoc).message
      else
        mes = handle.new(controller,events,action).message
      end

      @m.merge!(mes)
    end

    def message
      @m
    end
    
    def handler_for(controller)
      event_rules.each do |rule|
        rule.each_pair do |key,value|
          out = key.detect {|reg| reg =~ controller}
          unless out.nil?
              return ::Valyrian::Service.const_get(value),value
          end
        end
      end
      return ::Valyrian::Service.const_get(:Default),:default
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
        ["destroy","destroyed"],
        ["login","logged in"],
        ["logout", "logged out"]
      ]
    end

    def event_rules
      [
        {[/Session/,/cache_refresh/] => :StaticEvent},
        {[/geo_route_groups/] => :GeoRouteEvent},
        {[/company.*$/,/cache_url.*$/] => :CompanyEvent},
        {[/geo_route_groups/] => :GeoRouteEvent},
        {[/ani_groups/] => :AniGroupEvent},
        {[/preroute.*$/] => :PreRouteEvent},
        {[/dlis/] => :DliEvent },
        {[/frontend/] => :FrontEndNumberEvent},
        {[/activations/] => :ActivationEvent},
        {[/backend_number/] => :VlabelMapEvent},
        {[/packages/,/time_segments/,/profiles/,/routings/,/routing_destinations/] => :PackageEvent},
        {[/^groups$/] => :GroupOpEvent},
        {[/ivrs/] => :IvrEvent}
      ]
    end

    def pastify(action)
      result = action.to_s.dup
      action_rules.each { |(rule,replacement)| break if result.gsub!(rule,replacement)}
      @m["action"] = result
    end

  end
end
