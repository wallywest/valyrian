require 'spec_helper'

describe "GeoGroupEvent" do
  before(:each) do
    @georoutes= Alpha.georoute
    @single = @georoutes.first
    #@without_main_object
  end

  it "should set the template" do
    event = Valyrian::GeoRouteEvent.new(@single.controller,@single.action,@single.events)
    
    expect(event.message.template).to eq("georoute")
  end

   it "should find identifier by association if main object is not in events" do
    pending
    event = Valyrian::GeoRouteEvent.new(@single.controller,@single.action,@single.events)

    event.should_receive(:find_by_association)

    event.find_identifier
   end

   it "should call find_association_message on subevents" do

    event = Valyrian::GeoRouteEvent.new(@single.controller,@single.action,@single.events)

    event.should_receive(:find_association_message)

    event.find_changes
   end

   context "associaton message" do
     it "should add sub event message" do
       event = Valyrian::GeoRouteEvent.new(@single.controller,@single.action,@single.events)

       event.should_receive(:add_sub_event)

       event.find_changes
     end
   end

end
