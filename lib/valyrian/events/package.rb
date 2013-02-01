module Valyrian
class PackageEvent < Valyrian::Default
  attr_reader :message

  TEMPLATE = 'package'
  IDENTITY_FIELD = "name"
  RULES = [
    {:type => :object,
     :criteria => Proc.new {|audit| audit.action == "activated"},
     :method => :activation_subevent
    },
  ]

  def activation_subevent
    @events.each do |event|
      if event["type"].downcase == "package"
        if event["changed"]["active"] == [true,false]
          add_sub_event(deactivated_package(event))
        else
          set_identity(event["object"]["name"]) if missing_identity?
        end
      end
    end
  end

  private

  def deactivated_package(event)
    "Package #{event["object"][IDENTITY_FIELD]} was deactivated"
  end

end
end
