module Valyrian::Service
class AniGroupEvent < Valyrian::Service::Default

  def find_identifier(event)
    super
    find_by_association(event) if @identifier.nil?
  end

  def find_by_association(event)
    assoc = event["assoc"]
    set_identity(assoc["ani_group"]) if assoc
  end

  def format_message
    e = changed_events
    main_event.merge!({
      "changes" => e
    })
  end

  def template
    "anigroup"
  end

  def changed_events
    changed = []
    @events.each do |e|
      changed << e["changed"] if e["changed"]
    end
    changed
  end

end
end
