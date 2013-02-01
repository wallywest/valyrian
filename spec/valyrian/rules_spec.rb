require 'spec_helper'

include Valyrian::Rules

describe "rules" do
  context "action inflections" do
    it "should not raise error when inflecting controller actions" do
      ["create","update","destroy","copy","move_multiple","quick_edit_active_update"].each do |action|
        out = pastify(action)

        expect(out).not_to eq(action)
      end
    end
  end
end
