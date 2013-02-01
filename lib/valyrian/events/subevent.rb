require 'i18n'

module Valyrian
  class Subevent
    def initialize(type)
      I18n.load_path = [Valyrian::subevent_path]
      I18n.locale = :en
      @type = type
    end

    def message_for(event_string,interpolation)
      event_string = "#{@type}.#{event_string}"
      I18n.t(event_string,interpolation)
    end
  end
end
