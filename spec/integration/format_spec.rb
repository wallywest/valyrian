#require 'spec_helper'

#describe "Formated Messages" do
  #before(:each) do
    #@all_audits = Alpha.excludes(controller: "packages")
    #@skip = ["LocationEvent","PackageEvent"]
  #end

  #it "should have these keys defined" do
    #@all_audits.each do |audit|
      #event = Valyrian::Message.new(audit.attributes).formatted
      #message = event[:message]

      #next if @skip.include?(message.type)

      #message.identity.should be_a(String)

      #expect(message.template).not_to be("")
      #expect(message.template).not_to be(nil)
      #expect(message.identity).not_to be("")
      #expect(message.identity).not_to be(nil)
    #end
  #end

#end
