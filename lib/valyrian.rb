require 'virtus'
require 'multi_json'
require 'yaml'
require 'active_support/core_ext'
require "valyrian/error"

require 'valyrian/railtie.rb' if defined?(Rails)

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

  autoload :EventUtils, "valyrian/events/event_utils"
  autoload :Default, "valyrian/events/default"
  autoload :CompanyEvent, "valyrian/events/company"
  autoload :GeoRouteEvent, "valyrian/events/georoute"
  autoload :VlabelMapEvent, "valyrian/events/vlabelmap"

  autoload :PreRouteEvent, "valyrian/events/preroute"
  autoload :PreRouteEditEvent, "valyrian/events/preroute_edit"
  autoload :PreRouteConfigEvent, "valyrian/events/preroute_config"

  autoload :DliEvent, "valyrian/events/dli"
  autoload :FrontEndEvent, "valyrian/events/frontend"
  autoload :LocationEvent, "valyrian/events/location"

  autoload :PackageEvent, "valyrian/events/package"
  autoload :GroupOpEvent, "valyrian/events/groupop"
  autoload :IvrEvent, "valyrian/events/ivr"
  autoload :AniGroupEvent, "valyrian/events/anigroup"
  autoload :StaticEvent, "valyrian/events/static"

  autoload :Subevent, "valyrian/events/subevent"

  def self.logger=(logger)
    @logger = logger
  end
  
  def self.logger
    @logger
  end

end
