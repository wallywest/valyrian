module Valyrian
  class StatusAudit
    include Virtus

    attribute :ip, String
    attribute :app_id, Integer
    attribute :_id, String
    attribute :audit, String
    attribute :ts, String
    attribute :user, String
    attribute :event, Hash

    def formatted
      binding.pry
    end

  end
end
