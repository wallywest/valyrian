module Valyrian
class VlabelMapEvent < Valyrian::Default

  MAIN = "VlabelMap"
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
