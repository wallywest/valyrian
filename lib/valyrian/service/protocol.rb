module Valyrian::Service::Protocol
  def self.fetch_all(app_id)
    m = []
    raw_events = event.where(app_id: app_id).sort(ts: -1).to_a
    raw_events.each do |event|
      m << message.format(event)
    end
    m
  end

  def self.fetch_with_filter(app_id,filter)
    m = []
    raw_events = event.where(app_id: app_id, controller: /#{filter}/).sort(ts: -1).to_a
    raw_events.each do |event|
      m << message.format(event)
    end
    m
  end

  def self.fetch_versions_all(app_id,pid)
    id = {a: app_id.to_i, pk: pid.to_i, t: "package"}

    version.where(id: id).to_a
  end

  def self.fetch_version(app_id,pid,v)
    id = {a: app_id.to_i, pk: pid.to_i, t: "package"}

    version.where(id: id).version_pairs(v)
  end

  def self.fetch_event(oid)
    raw_event = event.find(oid)
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
