module Valyrian::Service
class GroupOpEvent < Valyrian::Service::Default


  def find_identifier(event)
    super
    find_by_association(event) if @identifier.nil?
  end

  def format_message
    e = changed_events
    main_event.merge!({
      "changes" => e,
      "context" => @context
    })
  end

  def find_by_association(event)
    assoc = event["assoc"]
    set_identity(assoc["group"]) if assoc
  end

  def object_name
    "Group"
  end

  def template
    "groupop"
  end
  
  def changed_events
    changed = []
    @events.each do |e|
      changed << e["changed"]
      #find_context(e) if @context.nil?
    end
    changed
  end

end
end

