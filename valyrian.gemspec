# encoding: utf-8
$:.push File.expand_path("../lib", __FILE__)
require "valyrian/version"

Gem::Specification.new do |gem|
  gem.authors = ["Justin Erny"]
  gem.platform = Gem::Platform::RUBY
  gem.email = 'jerny@vail.com'
  gem.rdoc_options = ["--main", "README.rdoc", "--line-numbers", "--inline-source"]
  gem.name = 'valyrian'
  gem.summary = %q{convert audits to event messages for racc}
  gem.test_files = `git ls-files -- spec/* test/*`.split("\n")
  gem.version = Valyrian::VERSION
  gem.date = Time.now.strftime('%Y-%m-%d')
  
  gem.add_dependency 'virtus'
  gem.add_dependency 'multi_json'
  gem.add_dependency 'activesupport'
  gem.add_dependency 'i18n'
  gem.add_development_dependency "rspec"
  gem.add_development_dependency "database_cleaner"
  gem.add_development_dependency "mongoid"

  gem.test_files    = gem.files.grep(/^spec\//)
  gem.files = `git ls-files`.split("\n")
  gem.require_paths = ["lib"]
end

