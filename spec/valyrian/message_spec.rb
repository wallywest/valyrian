require "spec_helper"

describe "Valyrian Message" do

  before(:each) do
    @event = Alpha.last
  end

  context "format" do
    before(:each) do
      @message = Valyrian::Message::new(@event.attributes.to_hash)
    end

    it "should translate the action" do

      Valyrian::Message.any_instance.should_receive(:formatted).with(@event.action)

      Valyrian::Message::new(@event.attributes.to_hash)
    end

    it "should find handler for a specific controller" do
     no = double('null object').as_null_object
     @message.should_receive(:find_handler_for).with(@event.controller).and_return(no)

     @message.format
    end

    it "should call an instance of the event handler" do
      @event.stub(:events).and_return([])
      @message.stub(:find_handler_for).and_return(Valyrian::PackageEvent)
      no = double('null object').as_null_object
      action = Valyrian::Rules.pastify(@event.action)

      Valyrian::PackageEvent.should_receive(:new).with(@event.controller,action,@event.events).and_return(no)

      @message.format
    end

    it "should have a message method with translated event" do
      @message.format

      expect(@message.message).to be_kind_of(Valyrian::EventMessage)
    end
  end

end
