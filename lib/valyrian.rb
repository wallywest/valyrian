require 'virtus'
require 'coercible'
require 'verbs'
require 'multi_json'
require 'yaml'
require 'active_support/core_ext'
require "valyrian/error"

require 'valyrian/railtie.rb' if defined?(Rails)

module Valyrian
  autoload :Rules, "valyrian/rules"
  autoload :Utils, "valyrian/utils"

  autoload :Events, "valyrian/events"
  autoload :Types, "valyrian/types"
  autoload :Message, "valyrian/message"

  class << self
    def rules
      #@rules ||= YAML.load_file(Rails.root + "config/valyrian.yml")
      @rules ||= YAML.load_file(Pathname.pwd.join('config/valyrian.yml'))
    end

    def subevent_path
      @subevents ||= Pathname.pwd.join('config/subevents.yml')
    end

    def logger=(logger)
      @logger = logger
    end
    
    def logger
      @logger
    end
  end

end
