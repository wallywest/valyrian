module Valyrian
class PreRouteEvent < Valyrian::Default

  def build_events
    case @controller
    when "preroute_edits"
      preroute_edit_events
    when "preroute_edit_configs"
      config_events
    when "preroute_groups"
      pg_events
    else
      pg_events
      #preroute_groupings
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
    @events.each do |event|
      e = event["event"]
      assoc = event["assoc"] 
      return if assoc.nil?
      preroute = assoc["preroute_grouping"]
      group = assoc["group"]
      case e
      when 'create'
        message = "Assigned preroute grouping #{preroute} to group #{group}"
      when 'destroy'
        message = "Removed preroute grouping #{preroute} from group #{group}"
      else
      end
      add_sub_event(message)
    end
  end

  def preroute_edit_events
    @events.each do |event|
      group = event["object"]["group"]
      c = event["changed"]["preroute_group_id"]
      assoc = event["assoc"]
      if value_disabled?(c)
        message = "PreRoute disabled for group #{group}"
      else
        return if assoc.nil?
        preroute = assoc["preroute_group"]
        message = "PreRoute #{preroute} enabled for group #{group}"
      end
      add_sub_event(message)
    end
  end

end
end
