module Valyrian
class IvrEvent < Valyrian::Default

  def template
    "ivr"
  end


  def changed_events
    changed = []
    @events.each do |e|
      changed << e["changed"]
    end
    changed
  end

  def object_rule
    rules["ivrs"]
  end

end
end
