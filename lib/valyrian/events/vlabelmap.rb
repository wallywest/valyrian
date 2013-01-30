module Valyrian
  class VlabelMapEvent < Valyrian::Default

    MAIN = "VlabelMap"
    TEMPLATE = 'vlabelmap'
    IDENTITY_FIELD = "group"
    ASSOC = "group"
    VLABEL_ASSOC = ['survey_group_id','preroute_group_id','geo_route_group_id']

    SUBEVENTS = [
      {:type => :object,
       :criteria => Proc.new { @type == "Package"},
       :method => :package_event
      },
      {:type => :object,
       :criteria => Proc.new { has_change?},
       :method => :vlabel_change_event
      }
    ]

    PackageEvent = Proc.new{|x| "Package #{x} was created and activated"}

    def package_event
      name = @object[Valyrian::PackageEvent::IDENTITY_FIELD]
      add_sub_event(PackageEvent.call(name))
    end

    def has_change?
      (@type == MAIN) && !@changed.nil?
    end

    def vlabel_change_event
      @changed.each do |key,value|
        if VLABEL_ASSOC.include?(key)
          message_for_assoc(key,value)
        else
          unless geo_route_change(value)
            changed << {key => value}
          end
        end
      end
    end

    def message_for_assoc(key,value)
      type = key.split("_id").first
      if value_disabled?(value)
        message = "#{type.classify} option is removed"
      else
        return if @assoc.nil?
        message = "#{type.classify} #{@assoc[type]} was added"
      end
      add_sub_event(message)
    end

    def geo_route_change(value)
      value.select{|x| x =~ /GEO_ROUTE_SUB0/}.size > 0
    end

    def value_disabled?(value)
      value[1].nil? || value[1] == 0
    end


  end
end
