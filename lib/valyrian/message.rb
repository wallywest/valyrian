module Valyrian
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
      assoc = @m.delete("assoc") || @m.delete("m") || @m.delete("meta")

      logger.info(@m["_id"])
      pastify(action)

      handle,value = handler_for(controller)
      if value == :PackageEvent
        #formatting is different for package messages, needs to become more uniform
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
              return ::Valyrian.const_get(value),value
          end
        end
      end
      return ::Valyrian.const_get(:Default),:default
    end

    def logger
      Valyrian.logger
    end

    def action_rules
      [
        [/quick_edit.*$/,'updated'],
        [/copy_multiple/,'copied'],
        [/move_multiple/,'moved'],
        [/destroy_multiple/,'destroyed'],
        [/create_copy/,'created'],
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
        {[/^frontend.*$/] => :FrontEndEvent},
        {[/activations/] => :ActivationEvent},
        {[/backend_number/] => :VlabelMapEvent},
        {[/packages/,/time_segments/,/profiles/,/routings/,/routing_destinations/] => :PackageEvent},
        {[/^groups$/] => :GroupOpEvent},
        {[/ivrs/] => :IvrEvent}
      ]
    end

    def pastify(action)
      unless action.nil?
        result = action
        action_rules.each { |(rule,replacement)| break if result.gsub!(rule,replacement) }
        @m["action"] = result
      end
    end

  end
end
