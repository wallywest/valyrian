require 'spec_helper'

describe "Valyrian::StaticEvent" do
  it "should only set the template" do
    @static_audits = [Alpha.session,Alpha.cache_refresh].flatten!
    @static_audits.each do |audit|
      event = Valyrian::Message.new(audit.attributes).format

      expect(event.template).not_to eq(nil)
      expect(event.meta).to eq({})
      expect(event.sub_events).to eq([])
      expect(event.changed).to eq([])
      expect(event.identity).to eq(nil)
    end
  end
end
