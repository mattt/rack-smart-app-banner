# frozen_string_literal: true

require 'bundler'
Bundler.setup

gemspec = eval(File.read('rack-smart-app-banner.gemspec'))

task build: "#{gemspec.full_name}.gem"

file "#{gemspec.full_name}.gem" => gemspec.files + ['rack-smart-app-banner.gemspec'] do
  system 'gem build rack-smart-app-banner.gemspec'
  system "gem install rack-smart-app-banner-#{Rack::SmartAppBanner::VERSION}.gem"
end
