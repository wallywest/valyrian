module Valyrian
class DliEvent < Valyrian::Default

  TEMPLATE = 'dli'
  MAIN = 'Dli'
  CHILDREN = ["Li","Destination"]

  def find_identifier
    super
    find_by_association if @identifier.nil?
  end

  def find_by_association
    set_identity(@assoc["dli"]) if @assoc
  end

  def find_changes
    @subevent = SubEvent.new("dli")
    self.send("#{@type.downcase}_event") if CHILDREN.include?(@type)
  end

  def li_event
    value,dpct = @object["value"], @object["dpct"]
    case @action
    when "create"
      message = @subevent.format_for("li.create",{:value => value, :pct => dpct})
    when "update"
      message = []
      @changed.each { |k,v| message << @subevnet.format_for("li.update", {:value => value, :old => v[0], :new => v[1]}) }
    else
      @subevent.format_for("li.destroy",{:value => value, :pct => dpct})
    end
    add_sub_event(message)
  end

  def destination_event
    destination = @object["destination"]
    case @action
    when "create"
      message = @subevent.format_for("destination.create",{:destination => destination})
    when "update"
      message = []
      @changed.each {|k,v| message << @subevent.format_for("destination.update",{:old => v[0], :new => v[1]})}
    else
      message = @subevent.format_for("destination.destroy",{:destination => destination})
    end
    add_sub_event(message)
  end

  def template
    TEMPLATE
  end

end
end
