require 'spec_helper'

module ValyrianTestHelper
  include Valyrian::Rules

  def self.find(type)
    audits = Alpha.all.to_a
    audits.select {|audit| type == find_handler_for(audit.controller).to_s }
  end
end
