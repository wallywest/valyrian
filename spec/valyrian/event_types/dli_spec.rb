require 'spec_helper'

describe "DliEvent" do
  before(:each) do
    @dlis = Alpha.dli
    @single = @dlis.first
  end

  it "should set the template" do
    pending "need to add mock data"
    event = Valyrian::DliEvent.new(@single.controller,@single.action,@single.events)
    
    expect(event.message.template).to eq("dli")
  end


end

