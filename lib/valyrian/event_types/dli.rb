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

  def find_messages
    self.send("#{@type.downcase}_event") if CHILDREN.include?(@type)
  end

  def li_event
    value = @object["value"]
    dpct = @object["dpct"]
    case @action
    when "create"
      message = "Trunk #{value} created with distribution of #{dpct}"
    when "update"
      message = []
      @changed.each { |k,v| message << "Trunk #{value} changed #{k} from #{v[0]} to #{v[1]}" }
    else
      message = "Trunk #{value} destroyed"
    end
    add_sub_event(message)
  end

  def destination_event
    destination = @object["destination"]
    case @action
    when "create"
      message = "Destination #{destination} created"
    when "update"
      message = []
      @changed.each {|k,v| message << "Destination updated from #{v[0]} to #{v[1]}" }
    else
      message = "Destination #{destination} destroyed"
    end
    add_sub_event(message)
  end

  def template
    TEMPLATE
  end

end
end
