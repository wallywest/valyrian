require 'spec_helper'

describe "VlabelMapEvent" do

  context "normal package operation" do 

    before(:each) do
      @vlabels = Alpha.vlabels
      @single = @vlabels.last
      @master_event = @single.master_event("VlabelMap")
    end

    it "should set template to package" do
      event = Valyrian::VlabelMapEvent.new(@single.controller,@single.action,@single.events)
      expect(event.message.template).to eq('vlabelmap')
    end

  end
end
