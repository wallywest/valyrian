module Valyrian
  class FrontEndEvent < Valyrian::Default
    TEMPLATE = 'frontend_group'
    ASSOC = 'group'

    SUBEVENTS = [
      {:type => :collection,
       :criteria => Proc.new {|x| x.has_key?(:collection)},
       :method => :collection_event
      },
      {:type => :object,
       :criteria => Proc.new {|x| x.has_key?(:object)},
       :method => :object_event
      },
      {
        :type => :change,
        :criteria => Proc.new do |x|
          x.has_key?(:changed)
        end,
        :method => :change_event
      }
    ]

    def collection_event
    end
    
    def object_event
    end

    def change_event
    end

  end
end

