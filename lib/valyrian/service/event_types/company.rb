module Valyrian::Service
class CompanyEvent < Valyrian::Service::Default

  TEMPLATE = 'company'

  def find_identifier
    set_identity(identifier)
  end

  def identifier
    "Company Settings"
  end

  def template
    TEMPLATE
  end

end
end
