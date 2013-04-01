module Valyrian::Events
class CompanyEvent < Valyrian::Events::Default

  TEMPLATE = 'company'
  IDENTITY_FIELD = "Company Settings"
  MAIN = ["Company", "CompanyConfig"]

end
end
