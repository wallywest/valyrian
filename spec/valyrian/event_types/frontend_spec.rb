require 'spec_helper'

describe "FrontEndEvent" do

  before(:each) do
    @f= Alpha.frontend
    @single = @f.first
  end

  it "should set the template" do
    pending
    #need to add company audit
    event = Valyrian::FrontEndEvent.new(@single.controller,@single.action,@single.events)
    
    expect(event.message.template).to eq("company")
  end

end
