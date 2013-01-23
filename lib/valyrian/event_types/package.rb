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

  def initialize(controller,action,events)
    @events = events
    @controller = controller
    @action = action
    
    @message = EventMessage.new


    SUBEVENTS.each do |s|
      if s[:type] == :action
        self.send(s[:method]) if s[:criteria].call(@action)
      end
    end

    set_defaults
    set_template(TEMPLATE)

    logger.info("Message: #{@message}\n Type: #{self.class}")
  end

  def set_defaults(event=nil)
    return save_info(event) if event
    @events.each do |event|
      if event["type"].downcase == TEMPLATE
        save_info(event)
      end
    end
  end


  def activation_subevent
    @events.each do |event|
      if event["type"].downcase == "package"
        if event["changed"]["active"] == [true,false]
          add_sub_event(deactivated_package(event))
        else
          set_defaults(event)
        end
      end
    end
  end

  private

  def save_info(event)
    name = event[IDENTITY_FIELD]
    set_identity(name)
    meta_information(event)
  end

  def meta_information(event)
    add_meta(event["meta"])
  end

  def deactivated_package(event)
    "Package #{event["object"][IDENTITY_FIELD]} was deactivated"
  end

  def template
    TEMPLATE
  end
end
end
