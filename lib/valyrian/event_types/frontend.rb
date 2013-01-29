module Valyrian
class FrontEndEvent < Valyrian::Default

    def default_values
      binding.pry
      @raw_events.each do |event|

        @type = event["type"]
        @assoc = event["assoc"] || event["meta"]
        @object = event["object"] || event["payload"]
        @changed = event["changed"]
        @action = event["event"] || event["action"]

        find_identifier if @identifier.nil?
        find_changes
      end
      self.sub_events.flatten!
      set_template(template)
    end

    def find_identifier
      super
      find_by_association if @identifier.nil?

    end
    def find_by_association
      set_identity(@assoc["group"]) if @assoc
    end

    def find_changes
      case @controller
      when 'frontend_numbers_uploads'
        #bulk upload event

        @caction = "uploaded"
        set_template('frontend_upload')

      when 'frontend_numbers'
        #adding/updating/destroying single/multiple vlabels with frontend
        set_template('frontend_number')
        set_moved(@object["mv"].size) if @caction == "moved"

      when 'frontend_groups'
        set_template('frontend_group')
        vlabel_change_event unless @changed.nil?
      else
      end
    end

    def set_moved(n)
      @message["count"] = n
    end
end
end
