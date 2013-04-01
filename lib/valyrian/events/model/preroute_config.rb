module Valyrian::Events
  class PreRouteConfigEvent < Valyrian::Events::Default
    TEMPLATE = 'preroute_config'

    SUBEVENTS = [
      {:type => :controller,
       :criteria => Proc.new {|event| event["type"] == "preroute_edit_configs"},
       :method => :config_events
      },
    ]

    def config_events
      @raw_events.each do |event|
        e = event["event"]
        assoc = event["assoc"]
        return if assoc.nil?
        preroute = assoc["preroute_grouping"]
        group = assoc["group"]
        message = @subevent.message_for("config.#{action}",{:group => group, :preroute => preroute})
        add_sub_event(message) if message
      end
    end

  end
end

