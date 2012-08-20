module Valyrian::Service::Protocol
  def self.fetch_all(app_id)
    m = []
    raw_events = event.where(app_id: app_id).sort(ts: -1).to_a
    raw_events.each do |event|
      m << message.format(event)
    end
    m
  end

  def self.fetch_event(oid)
    raw_event = event.find(oid)
  end

  def self.message_types
    [
      {[/company$/] => CompanyEvent},
      {[/ani_group$/,/geo_route_group/] => GeoRouteEvent},
      {[/preroute$/] => PreRouteEvent},
      {[/dli$/] => DliEvent },
      {[/frontend_number$/] => FrontEndNumberEvent},
      {[/activations$/] => ActivationEvent},
      {[/backendnumber$/] => VlabelMapEvent}
    ]
  end

  def self.event
    Valyrian::Event
  end

  def self.version
    Valyrian::Version
  end

  def self.message
    Valyrian::Service::Message
  end
end
