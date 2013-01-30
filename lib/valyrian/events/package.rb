module Valyrian
class PackageEvent < Valyrian::Default
  attr_reader :message

  TEMPLATE = 'package'
  IDENTITY_FIELD = "name"
  SUBEVENTS = [
    {:type => :action,
     :criteria => Proc.new {|x| x =~ /activate$/},
     :method => :activation_subevent
    },
  ]

  #SUBEVENTS.each do |s|
    #if s[:type] == :action
      #self.send(s[:method]) if s[:criteria].call(@action)
    #end
  #end

  def activation_subevent
    @events.each do |event|
      if event["type"].downcase == "package"
        if event["changed"]["active"] == [true,false]
          add_sub_event(deactivated_package(event))
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
