module Valyrian::Service
class GroupOpEvent < Valyrian::Service::Default

  TEMPLATE = 'groupop'

  def find_identifier
    super
    find_by_association if @identifier.nil?
  end

  def find_by_association
    set_identity(@assoc["group"]) if @assoc
  end

  def object_name
    "Group"
  end

  def template
    TEMPLATE
  end
  
end
end

