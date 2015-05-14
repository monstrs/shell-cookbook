require 'busser/rubygems'
Busser::RubyGems.install_gem('rspec-extra-formatters', '~> 1.0.0')
Busser::RubyGems.install_gem('rspec-legacy_formatters', '~> 1.0.0')

require 'rspec/legacy_formatters'
require 'rspec-extra-formatters'
require 'serverspec'

# Require support files
Dir[File.expand_path('../support/**/*.rb', __FILE__)].each { |file| require_relative(file) }

RSpec.configure do |config|
  config.formatter = 'TapFormatter'
end
