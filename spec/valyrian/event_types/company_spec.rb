require 'spec_helper'

describe "CompanyEvent" do

  before(:each) do
    @company = Alpha.company
    @single = @company.first
  end

  it "should set the template" do
    pending
    #need to add company audit
    event = Valyrian::AniGroupEvent.new(@single.controller,@single.action,@single.events)
    
    expect(event.message.template).to eq("company")
  end

end
