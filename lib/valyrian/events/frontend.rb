module Valyrian
  class FrontEndEvent < Valyrian::Default
    TEMPLATE = 'frontend_group'
    ASSOC = 'group'

    OVERRIDE = {
      :action => Proc.new do |controller,action|
        "updated" if ["move_multiple","copy_multiple"].include?(action)
      end
    }

    SUBEVENTS = [

      {:type => :collection,
       :criteria => Proc.new {|x| x["action"] == "move_vlabels" || x["action"] == "copy_vlabels"},
       :method => :move_vlabels_event
      },

      {:type => :object,
       :criteria => Proc.new {|x| x.has_key?("object")},
       :method => :object_event
      },
      {
        :type => :changed,
        :criteria => Proc.new {|x|
          x.has_key?("changed") &&
          x["type"] != "Operation" &&
          x["action"] != "move_vlabels" &&
          x["action"] != "copy_vlabels"
        },
        :method => :change_event
      },
      {
        :type => :object,
        :criteria => Proc.new {|x| x.has_key?("changed") && x["type"] == "Operation"},
        :method => :set_default_route
      }
    ]

    def set_default_route(event)
      changed = event["changed"]["newop_rec"]
      object = event["object"]
      m = "Default route set to #{changed[1]}"
      add_sub_event(m)
    end

    def move_vlabels_event(event)
      total = event["collection"].size
      identity = event["changed"]["group"][1]["display_name"]
      set_identity(identity)

      case event["action"]
      when "move_vlabels"
        add_sub_event("#{total} vlabels moved into #{identity}")
      when "copy_vlabels"
        add_sub_event("#{total} vlabels copied into")
      end
    end
    
    def object_event(event)
    end

    def change_event(event)
      m = []
      event["changed"].except("type").each do |key,value|
        type = key.classify
        field = assoc_field_for(key.pluralize)
        m << diff_message(type,field,value[0],value[1])
      end
      add_sub_event(m) unless m.empty?
    end

  end
end

