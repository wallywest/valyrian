require 'spec_helper'

include Valyrian::Rules

describe "rules" do
  context "action inflections" do
    it "should not raise error when inflecting controller actions" do
      controller = "blah_controller"
      handler = ::Valyrian::Events.const_get(:Default)

      ["create","update","destroy","copy","move_multiple","quick_edit_active_update"].each do |action|
        out = pastify(action,controller,handler)

        expect(out).not_to eq(action)
      end
    end
  end
end
