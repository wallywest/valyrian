module Valyrian
  class PreRouteEditEvent< Valyrian::Default

    MAIN = ["VlabelMap"]
    TEMPLATE = 'preroute_edits'
    IDENTITY_FIELD = "group"
    ASSOC = "group"
    PREROUTE_ASSOC = ['preroute_group_id']

    SUBEVENTS = [
      {:type => :changed,
       :criteria => Proc.new {|e| e.has_key?("changed") && e.has_key?("object")},
       :method => :object_event
      },
      {:type => :changed,
       :criteria => Proc.new {|e| e.has_key?("changed") && e.has_key?("collection")},
       :method => :collection_event
      }
    ]

    def collection_event(event)
      changed = event["changed"]
      preroute = changed["preroute_group"] || changed["preroute_group_id"]
      m = diff_message("PreRouteGroup","group_name",preroute[0],preroute[1])
      add_sub_event(m)
    end

    def object_event(event)
      changed = event["changed"]
      preroute = changed["preroute_group"] || changed["preroute_group_id"]
      m = diff_message_id("PreRouteGroup",@assoc["preroute_group"], preroute[0],preroute[1])
      add_sub_event(m)
    end

  end
end


