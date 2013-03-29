module Valyrian
  class Message
    attr_accessor :model
    delegate :formatted, :to => :model

    def initialize(attributes)
      type = attributes["audit_type"] ||= "model"
      @model = Valyrian.const_get("#{type}_audit".classify).new(attributes)
    end
  end
end
