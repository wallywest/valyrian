module Valyrian::Service
class CompanyEvent < Valyrian::Service::Default

  def find_identifier(event)
    set_identity(identifier)
  end

  def identifier
    "Company Settings"
  end

  def template
    "company"
  end

  def object_rule
    true
  end
  
  def changed_events
    changed = []
    @events.each do |e|
      changed << e["changed"]
    end
    changed
  end

end
end
