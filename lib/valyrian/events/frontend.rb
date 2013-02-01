module Valyrian
  class FrontEndEvent < Valyrian::Default
    TEMPLATE = 'frontend_group'
    ASSOC = 'group'

    SUBEVENTS = [
      {:type => :collection,
       :criteria => Proc.new {|x| x.has_key?("collection")},
       :method => :collection_event
      },
      {:type => :object,
       :criteria => Proc.new {|x| x.has_key?("object")},
       :method => :object_event
      },
      {
        :type => :changed,
        :criteria => Proc.new {|x| x.has_key?("changed") && x["type"] != "Operation"},
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

    def collection_event(event)
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

