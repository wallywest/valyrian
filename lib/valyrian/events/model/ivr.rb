module Valyrian
  class IvrEvent < Valyrian::Default
    TEMPLATE = 'ivr'

    #temporary
    def find_identifier
      set_identity("ivr")
    end

  end
end


