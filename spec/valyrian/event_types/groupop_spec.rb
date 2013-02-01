require 'spec_helper'

describe "GroupOp" do
  before(:each) do
    @group= Alpha.groupop
    @single = @group.first
  end

  it "should set the template" do
    pending
    event = Valyrian::GroupOpEvent.new(@single.controller,@single.action,@single.events)
    
    expect(event.message.template).to eq("groupop")
  end

  it "should set the object name" do
    pending
    event = Valyrian::GroupOpEvent.new(@single.controller,@single.action,@single.events)

    expect(event.object_name).to eq("Group")
  end

  it "should call find_by_association when finding identity" do
    pending
    Valyrian::AniGroupEvent.any_instance.should_receive(:find_by_association).at_least(:once)

    Valyrian::GroupOpEvent.new(@single.controller,@single.action,@single.events)
  end

end
