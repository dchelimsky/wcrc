require 'rubygems'
require 'spork'

Spork.prefork do
ENV["RAILS_ENV"] ||= 'test'
require "config/environment"
require 'spec/autorun'
require 'spec/rails'

# Requires supporting files with custom matchers and macros, etc,
# in ./support/ and its subdirectories.
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each {|f| require f}

Spec::Runner.configure do |config|
  config.use_transactional_fixtures = true
  config.use_instantiated_fixtures  = false
  config.fixture_path = RAILS_ROOT + '/spec/fixtures/'
end
end

Spork.each_run do
end
