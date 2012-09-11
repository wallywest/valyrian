require 'debugger'
require 'hashie'
require 'mongoid'
require 'multi_json'
require 'yaml'
require 'active_support/core_ext'

module Valyrian

  def self.rules(rule)
    lib = $:.last
    @rules ||= YAML.load_file("#{lib}/valyrian/service/event_types/#{rule}.yml")
  end

  autoload :Event, "valyrian/models/event"
  autoload :Version, "valyrian/models/version"

  module Service
    autoload :App, "valyrian/service/app"
    autoload :Protocol, "valyrian/service/protocol"
    autoload :Message, "valyrian/service/message"

    autoload :Default, "valyrian/service/event_types/default"
    autoload :CompanyEvent, "valyrian/service/event_types/company"
    autoload :GeoRouteEvent, "valyrian/service/event_types/georoute"
    autoload :VlabelMapEvent, "valyrian/service/event_types/vlabelmap"
    autoload :PreRouteEvent, "valyrian/service/event_types/preroute"
    autoload :DliEvent, "valyrian/service/event_types/dli"
    autoload :ActivationEvent, "valyrian/service/event_types/activation"
    autoload :FrontEndEvent, "valyrian/service/event_types/frontend"

    autoload :PackageEvent, "valyrian/service/event_types/package"
    autoload :GroupOpEvent, "valyrian/service/event_types/groupop"
    autoload :IvrEvent, "valyrian/service/event_types/ivr"
    autoload :AniGroupEvent, "valyrian/service/event_types/anigroup"
    autoload :StaticEvent, "valyrian/service/event_types/static"

  end

  def self.logger
    Logger.new("valyrian.log")
  end

end
