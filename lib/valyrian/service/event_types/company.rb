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

end
end
