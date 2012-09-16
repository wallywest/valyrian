#require 'valyrian/service/event_types/frontend/uploads'
#require 'valyrian/service/event_types/frontend/numbers'
#require 'valyrian/service/event_types/frontend/groups'
module Valyrian::Service

  class FrontEndEvent < Valyrian::Service::Default

    ASSOC = ['survey_group_id','preroute_group_id','geo_route_group_id']

    def find_identifier
      super
      find_by_association if @identifier.nil?
    end

    def find_by_association
      set_identity(@assoc["group"]) if @assoc
    end

    def find_messages
      case @controller
      when 'frontend_numbers_uploads'
        #bulk upload event

        @caction = "uploaded"
        set_template('frontend_upload')
        
      when 'frontend_numbers'
        set_template('frontend_number')
        case @caction
        when 'destroyed'
        when 'moved'
          set_moved(@object["mv"].size)
        else
        end

        #adding/updating/destroying single/multiple vlabels with frontend
        
      when 'frontend_groups'
        set_template('frontend_group')
        vlabel_change_event unless @changed.nil?
      else
      end
    end

    def vlabel_change_event
      @changed.each do |key,value|
        if ASSOC.include?(key)
          message_for_assoc(key,value)
        else
          changed << {key => value}
        end
      end
    end

    def message_for_assoc(key,value)
      type = key.split("_id").first
      if value[1].nil? || value[1] == 0
        message = "#{type.classify} option is removed"
      else
        return if @assoc.nil?
        message = "#{type.classify} #{@assoc[type]} was added"
      end
      add_sub_event(message)
    end

    def set_template(t)
      @message["template"] = t
    end

    def set_moved(n)
      @message["count"] = n
    end
end
end
