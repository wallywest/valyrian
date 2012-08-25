module Valyrian::Service
class DliEvent < Valyrian::Service::Default

  def find_identifier(event)
    super
    find_by_association(event) if @identifier.nil?
  end

  def find_by_association(event)
    set_identity(assoc["dli"]) if event['assoc']
  end

  def format_message
    e = changed_events
    main_event.merge!({
      "changes" => e
    })
  end

  def template
    "dli"
  end

end
end
