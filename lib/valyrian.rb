require 'virtus'
require 'multi_json'
require 'yaml'
require 'active_support/core_ext'

module Valyrian

  def self.rules
    #@rules ||= YAML.load_file(Rails.root + "config/valyrian.yml")
    @rules ||= YAML.load_file(Pathname.pwd.join('config/valyrian.yml'))
  end

  def self.subevent_path
    @subevents ||= Pathname.pwd.join('config/subevents.yml')
  end

  autoload :Rules, "valyrian/rules"
  autoload :Utils, "valyrian/utils"

  autoload :Message, "valyrian/message"
  autoload :EventMessage, "valyrian/event_message"
  autoload :EventParser, "valyrian/event_parser"

  autoload :Default, "valyrian/event_types/default"
  autoload :CompanyEvent, "valyrian/event_types/company"
  autoload :GeoRouteEvent, "valyrian/event_types/georoute"
  autoload :VlabelMapEvent, "valyrian/event_types/vlabelmap"
  autoload :PreRouteEvent, "valyrian/event_types/preroute"
  autoload :DliEvent, "valyrian/event_types/dli"
  autoload :ActivationEvent, "valyrian/event_types/activation"
  autoload :FrontEndEvent, "valyrian/event_types/frontend"

  autoload :PackageEvent, "valyrian/event_types/package"
  autoload :GroupOpEvent, "valyrian/event_types/groupop"
  autoload :IvrEvent, "valyrian/event_types/ivr"
  autoload :AniGroupEvent, "valyrian/event_types/anigroup"
  autoload :StaticEvent, "valyrian/event_types/static"

  autoload :Discovery, "valyrian/event_types/discovery"
  autoload :Subevent, "valyrian/event_types/subevent"

  def self.logger
    Logger.new("valyrian.log")
  end

end
