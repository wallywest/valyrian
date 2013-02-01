require 'spec_helper'

describe "PackageEvent" do

  context "normal package operation" do 

    before(:each) do
      @package_audit = Alpha.packages.no_activations
      @single = @package_audit.last
      @master_event = @single.master_event("Package")
    end

    it "should set template to package" do
        event = Valyrian::PackageEvent.new(@single.controller,@single.action,@single.events)

        expect(event.message.template).to eq('package')
    end

    it "should call set_defaults on a non activation event" do
        Valyrian::PackageEvent.any_instance.should_receive(:set_defaults)

        Valyrian::PackageEvent.new(@single.controller,@single.action,@single.events)
    end

    it "should identity defined to find identity from object" do
      expect(Valyrian::PackageEvent::IDENTITY_FIELD).to eq("name")
    end

    it "should set meta subevents during set_defaults" do
        event = Valyrian::PackageEvent.new(@single.controller,@single.action,@single.events)

        event.should_receive(:meta_information).with(@master_event)

        event.set_defaults
    end
  end

  context "activation" do
    before(:each) do
      @activation_audit= Alpha.packages.activations
      @single = @activation_audit.last
      @deac,@activate = @single.activation_events("Package")
    end

    it "should call the activation subevent"  do
        Valyrian::PackageEvent.any_instance.should_receive(:activation_subevent)

        Valyrian::PackageEvent.new(@single.controller,@single.action,@single.events)
    end

    it "should format deactivated package message" do
        event = Valyrian::PackageEvent.new(@single.controller,@single.action,@single.events)

        event.should_receive(:deactivated_package).with(@deac)

        event.activation_subevent
    end

    it "should set defaults for activated package" do
        event = Valyrian::PackageEvent.new(@single.controller,@single.action,@single.events)

        event.should_receive(:set_defaults).with(@activate)

        event.activation_subevent
    end

    it "should format message of deactivation subevent" do
        event = Valyrian::PackageEvent.new(@single.controller,@single.action,@single.events)

        package = @deac["object"][Valyrian::PackageEvent::IDENTITY_FIELD]
        event.activation_subevent
        
        expect(event.message.sub_events).to eq(["Package #{package} was deactivated"])
    end

  end
end
