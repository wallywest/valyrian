module Valyrian
  module Rules
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
        {[/ani_groups/] => :AniGroupEvent},
        {[/preroute_edits/] => :PreRouteEditEvent},
        {[/preroute.*$/] => :PreRouteEvent},
        {[/dlis/] => :DliEvent },
        {[/^frontend.*$/] => :FrontEndEvent},
        {[/activations/] => :ActivationEvent},
        {[/backend_number/] => :VlabelMapEvent},
        {[/packages/,/time_segments/,/profiles/,/routings/,/routing_destinations/] => :PackageEvent},
        {[/admin_groups$/] => :GroupOpEvent},
        {[/^groups$/] => :GroupOpEvent},
        {[/ivrs/] => :IvrEvent},
        {[/location/] => :LocationEvent}
      ]
    end

    def find_handler_for(controller)
      event_rules.each do |rule|
        rule.each_pair do |key,value|
          out = key.detect {|reg| reg =~ controller}
          return ::Valyrian.const_get(value) unless out.nil?
        end
      end
      return ::Valyrian.const_get(:Default)
    end

    def pastify(action)
      unless action.nil?
        result = action.dup
        action_rules.each { |(rule,replacement)| break if result.gsub!(rule,replacement) }
        result
      end
    end

    def self.field_for_event(event_type)
      extend self
      event_rules.each do |rule|
        if rule.values.first == event_type
          return rule.keys
        end
      end
      []
    end

  end
end
