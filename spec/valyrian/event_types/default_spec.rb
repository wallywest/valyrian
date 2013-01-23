require 'spec_helper'

describe "DefaultEvent" do
  before(:each) do
    @audits = ValyrianTestHelper::find("Valyrian::Default")
    @single = @audits.first
  end

  context "new" do

    it "should call build events on initialization" do
      Valyrian::Default.any_instance.should_receive(:default_values)

      Valyrian::Default.new(@single.controller,@single.action,@single.events)
    end
  end

  context "default values" do
    before(:each) do
      @message = Valyrian::Default.new(@single.controller,@single.action,@single.events)
      @rules = @message.rules
      @event = @single.events.first
    end

    it "should set the template to the controller singularized value" do
      message = Valyrian::Default.new(@single.controller,@single.action,@single.events)

      expect(message.message.template).to eq(@single.controller.singularize)
    end

    context "identity" do
      it "should set attributes according to rules object definition" do
        expect(@message.attributes).to be(@rules[@single.controller]["object"])
      end

      it "should set identity field based on rule definition based on model value" do
        expect(@message.object_name).to be(@rules[@single.controller]["model"])
      end

      it "should set_identity based on object_name" do
        @message.should_receive(:set_identity)

        @message.find_identifier
      end
    end

    context "changes" do 
      it "should add changes to message if present" do
        expect(@message.message.changed).not_to be_empty
      end

      it "should not have any changes if not present" do
        @single.stub!(:events).and_return([])

        m = Valyrian::Default.new(@single.controller,@single.action,@single.events)

        expect(m.message.changed).to be_empty
      end

    end

  end

end

