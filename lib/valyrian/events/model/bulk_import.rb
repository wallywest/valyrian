module Valyrian::Events
  class BulkImportEvent < Valyrian::Events::Default
    TEMPLATE = 'bulk_import'
    SUBEVENTS = [
      {:type => :action,
      :criteria => Proc.new {|event| return true},
      :method => :count_objects
      }
    ]

    def count_objects
    end
  end
end

