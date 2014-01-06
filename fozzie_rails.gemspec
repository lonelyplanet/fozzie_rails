# -*- encoding: utf-8 -*-
require File.expand_path('../lib/fozzie/rails/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Marc Watts"]
  gem.email         = ["marc.watts@lonelyplanet.co.uk"]
  gem.summary       = %q{Ruby gem from Lonely Planet Online to register statistics in Rails}
  gem.description   = %q{Gem to make statistics sending from Rails applications simple and efficient as possible}
  gem.homepage      = "http://devops.lonelyplanet.com"
  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(spec|features)/})
  gem.name          = "fozzie_rails"
  gem.require_paths = ["lib"]
  gem.version       = Fozzie::Rails::VERSION

  gem.rubyforge_project = "fozzie_rails"

  gem.required_ruby_version = ">= 1.9.3"

  gem.add_dependency 'fozzie', '1.0.1'

  gem.add_development_dependency 'rake'
  gem.add_development_dependency 'rspec'
  gem.add_development_dependency 'guard'
  gem.add_development_dependency 'guard-rspec'
  gem.add_development_dependency 'rb-fsevent'

  gem.add_development_dependency 'activesupport'
  gem.add_development_dependency 'actionpack'
  gem.add_development_dependency 'railties'
  gem.add_development_dependency 'tzinfo'
end
