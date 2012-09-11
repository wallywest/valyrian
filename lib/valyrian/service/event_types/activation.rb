module Valyrian::Service
class ActivationEvent < Valyrian::Service::Default

  TEMPLATE = 'activation'

  def build_events
    events = @events.select {|x| x["type"] == "Package" }
    events.each do |e|
      object = e["object"]
      name = object["name"]
      changed = e["changed"]

      if deactivated(changed)
        add_sub_event(inactive_package_message(name))
      else
        set_identity(name)
      end
    end
  end

  def template
    TEMPLATE
  end
  
  def deactivated(changed)
    if changed.has_key?("active")
      return changed["active"].first == true
    end
    false
  end

  def inactive_package_message(name)
    "Package #{name} was deactivated"
  end


end
end
