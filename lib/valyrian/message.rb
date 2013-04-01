module Valyrian
  class Message

    def initialize(attributes)
      type = attributes["audit_type"] ||= "model"
      @type = Valyrian::Types.const_get("#{type}_audit".classify).new(attributes)

      if @type.respond_to?(:formatted)
        @type = @type.formatted
      end
    end

    def message
      @type.as_json
    end

  end
end
