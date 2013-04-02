module Valyrian::Events
  class VlabelMapEvent < Valyrian::Events::Default

    MAIN = ["VlabelMap"]
    TEMPLATE = 'vlabelmap'
    IDENTITY_FIELD = "group"
    ASSOC = "group"
    VLABEL_ASSOC = ['survey_group_id','preroute_group_id','geo_route_group_id']

    SUBEVENTS = [
      {:type => :object,
       :criteria => Proc.new {|event| event["type"] == "Package"},
       :method => :package_event
      },
      {:type => :changed,
       :criteria => Proc.new {|e| e.has_key?("changed")},
       :method => :vlabel_change_event
      }
    ]

    PackageCreate = Proc.new{|x| "Package #{x} was created and activated"}
    PackageDestroy = Proc.new{|x| "Package #{x} was destroyed"}

    def package_event(event)
      name = @object[Valyrian::Events::PackageEvent::IDENTITY_FIELD]

      case event["action"]
      when "destroy"
        add_sub_event(PackageDestroy.call(name))
      when "create"
        add_sub_event(PackageCreate.call(name))
      else
      end
    end

    def vlabel_change_event(event)
      changed = event["changed"]
      changed.except("type").each do |key,value|
        if VLABEL_ASSOC.include?(key)
          message_for_assoc(key,value)
        else
          if MAIN.include?(@type)
            add_change_message({key => value}) unless geo_route_change(value)
          end
        end
      end
    end

    def message_for_assoc(key,value)
      type = key.split("_id").first
      if value_disabled?(value)
        message = "#{type.classify} option was removed"
      else
        return if @assoc.nil?
        message = "#{type.classify} #{@assoc[type]} was enabled"
      end
      add_sub_event(message)
    end

    def geo_route_change(value)
      value.select{|x| x =~ /GEO_ROUTE_SUB/}.size > 0
    end

    def value_disabled?(value)
      value[1].nil? || value[1] == 0
    end

  end
end
