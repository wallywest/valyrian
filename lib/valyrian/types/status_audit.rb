module Valyrian::Types
  class StatusAudit
    include Virtus

    attribute :ip, String
    attribute :app_id, Integer
    attribute :_id, String
    attribute :ts, String
    attribute :event, Hash
    attribute :template, String, :default => "status"
  end
end
