require "rails/railtie"

module Valyrian
  class Railtie < ::Rails::Railtie
    initializer "setup logger" do
      l = Logger.new(File.join(Rails.root,'log','valyrian.log'))
      l.formatter = Logger::Formatter.new
      Valyrian::logger = l
    end
  end
end
