# encoding: utf-8
$:.push File.expand_path("../lib", __FILE__)
require "valyrian/version"

Gem::Specification.new do |gem|
  gem.authors = ["Justin Erny"]
  gem.platform = Gem::Platform::RUBY
  gem.email = 'jerny@vail.com'
  gem.rdoc_options = ["--main", "README.rdoc", "--line-numbers", "--inline-source"]
  gem.name = 'valyrian'
  gem.summary = %q{api to get event messages from racc}
  gem.test_files = `git ls-files -- spec/* test/*`.split("\n")
  gem.version = Valyrian::VERSION
  gem.date = Time.now.strftime('%Y-%m-%d')

  gem.files = `git ls-files`.split("\n")
  gem.require_paths = ["lib"]
  gem.add_dependency 'hashie'
end

