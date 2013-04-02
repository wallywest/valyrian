module Valyrian::Events
  class BulkImportEvent < Valyrian::Events::Default
    TEMPLATE = 'bulk_import'
    RULES = [
      {
        :criteria => Proc.new { true },
        :method => :count_objects
      }
    ]


    def counters
      @counters ||= []
    end

    def find_or_create_counter(type)
      counter = counters.select {|x| x.type == type}.first
      if counter.nil?
        counter = Counter.new(type)
        counters << counter
      end
      counter
    end


    def count_objects
      @events.each do |event|
        type = event["type"]
        counter = find_or_create_counter(type)
        counter.increment
      end
      add_messages
    end

    def add_messages
      counters.each do |c|
        add_sub_event(c.message)
      end
    end

  end
end

class Counter
  attr_accessor :type
  def initialize(type)
    @type = type
    @count = 0
  end

  def increment
    @count = @count + 1
  end
  
  def message
    "Imported #{@count} #{@type.pluralize}"
  end
end

