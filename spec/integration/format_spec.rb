require 'spec_helper'

describe "Formated Messages" do
  before(:each) do
    @all_audits = Alpha.all.to_a
  end

  it "should have these keys defined" do
    @all_audits.each do |audit|
      pp audit.attributes
      event = Valyrian::Message.new(audit.attributes).formatted
    end
  end
end
