# frozen_string_literal: true

$LOAD_PATH.push File.expand_path('lib', __dir__)
require 'rack/smart-app-banner'

Gem::Specification.new do |s|
  s.name        = 'rack-smart-app-banner'
  s.authors     = ['Mattt']
  s.email       = 'mattt@me.com'
  s.license     = 'MIT'
  s.homepage    = 'https://github.com/mattt/rack-smart-app-banner'
  s.version     = Rack::SmartAppBanner::VERSION
  s.platform    = Gem::Platform::RUBY
  s.summary     = 'rack-smart-app-banner'
  s.description = 'Rack middleware to automatically include code for Smart App Banner, introduced in iOS 6.'

  s.add_runtime_dependency 'rack', '>= 1.2.0', '< 2.0.0'

  s.add_development_dependency 'minitest',  '~> 2.11'
  s.add_development_dependency 'rack-test', '~> 0.6'
  s.add_development_dependency 'rake'

  s.files         = Dir['./**/*'].reject { |file| file =~ %r{\./(bin|log|pkg|script|spec|test|vendor)} }
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map { |f| File.basename(f) }
  s.require_paths = ['lib']
end
