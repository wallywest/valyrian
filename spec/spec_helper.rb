# Requires supporting ruby files with custom matchers and macros, etc,
# in spec/support/ and its subdirectories.
SPEC_ROOT = Pathname.new(File.expand_path('../', __FILE__))
require 'pry'
require 'json'
require 'ostruct'
require 'valyrian'
require 'database_cleaner'
require 'mongoid'
require 'pry'

Dir[SPEC_ROOT.join('support/*.rb')].each{|f| require f }


RSpec.configure do |config|
  include ValyrianTestHelper
  # == Mock Framework
  #
  # If you prefer to use mocha, flexmock or RR, uncomment the appropriate line:
  #
  # config.mock_with :mocha
  # config.mock_with :flexmock
  # config.mock_with :rr
  config.mock_with :rspec
  config.before(:suite) do
    DatabaseCleaner.strategy = :truncation
    DatabaseCleaner.start
    Mongoid.load!(SPEC_ROOT.join('config/mongoid.yml'),:test)
    import_events
  end

  config.after(:suite) do
    DatabaseCleaner.clean
  end

  # If you're not using ActiveRecord, or you'd prefer not to run each of your
  # examples within a transaction, remove the following line or assign false
  # instead of true.
  config.filter_run_excluding :exclude => true
end

def import_events
  `mongoimport -d valyrian_test -c alpha --file #{SPEC_ROOT.join("support/dump_alpha.json")}`
end
