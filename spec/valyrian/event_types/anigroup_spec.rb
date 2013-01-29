require 'spec_helper'

describe "AniGroupEvent" do
  before(:each) do
    @ani_audits = Alpha.anis
    @single = @ani_audits.first
  end

  it "should set the template" do
    event = Valyrian::AniGroupEvent.new(@single.controller,@single.action,@single.events)
    
    expect(event.message.template).to eq("anigroup")
  end

  it "should call write ani message with default values" do
    Valyrian::AniGroupEvent.any_instance.should_receive(:write_ani_messages)

    Valyrian::AniGroupEvent.new(@single.controller,@single.action,@single.events)
  end

   it "should find identifier by association" do
    Valyrian::AniGroupEvent.any_instance.should_receive(:find_by_association).at_least(:once)

    Valyrian::AniGroupEvent.new(@single.controller,@single.action,@single.events)
   end
end
