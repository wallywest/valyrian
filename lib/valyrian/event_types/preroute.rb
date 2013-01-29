module Valyrian
class PreRouteEvent < Valyrian::Default

  def default_values
    @subevent = Subevent.new("preroute")

    #need to classify event/collectionevent
    case @controller
    when "preroute_edits"
      preroute_edit_events
    when "preroute_edit_configs"
      config_events
    else
      pg_events
    end
  end

  def pg_events
    @events.each do |event|
      @changed = event["changed"]
      @object = event["object"]
      @type = event["type"]

      find_pg if @identifier.nil?
      changed << @changed if @changed
    end
  end

  def find_pg
    attributes.each do |attr|
      if @type == object_name
        set_identity(@object[attr])
      end
    end
  end

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

  def preroute_edit_events
    @raw_events.each do |event|
      group = event["object"]["group"]
      c = event["changed"]["preroute_group_id"]
      assoc = event["assoc"]
      if value_disabled?(c)
        message = @subevent.message_for("edit.disabled",{:group => group})
      else
        return if assoc.nil?
        message = @subevent.message_for("edit.enabled",{:preroute => preroute, :group => group})
      end
      add_sub_event(message)
    end
  end

end
end
