module Valyrian::Service
class VlabelMapEvent < Valyrian::Service::Default

  MAIN = "VlabelMap"
  ASSOC = ['survey_group_id','preroute_group_id','geo_route_group_id']
  TEMPLATE = 'vlabelmap'
  PackageEvent = Proc.new{|x| "Package #{x} was created and activated"}

  def find_messages
    package_event if has_package
    vlabel_change_event if has_change
  end

  def find_by_association
    set_identity(@assoc["group"]) if @assoc
  end

  def package_event
    name = @object["name"]
    add_sub_event(PackageEvent.call(name))
  end

  def vlabel_change_event
    @changed.each do |key,value|
      if ASSOC.include?(key)
        message_for_assoc(key,value)
      else
        changed << {key => value}
      end
    end
  end

  def message_for_assoc(key,value)
    type = key.split("_id").first
    if value[1].nil?
      message = "#{type.classify} option is removed"
    else
      return if @assoc.nil?
      message = "#{type.classify} #{@assoc[type]} was added"
    end
    add_sub_event(message)
  end

  def template
    TEMPLATE
  end

  def has_change
    (@type == MAIN) && !@changed.nil?
  end

  def has_package
    @type == "Package"
  end

end
end
