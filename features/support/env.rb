# Generated by cucumber-sinatra. (Mon Sep 03 23:08:46 +0100 2012)
ENV['RACK_ENV'] = 'test'
require 'simplecov'

require 'capybara'
require 'capybara/cucumber'
require 'rest-assured'
require 'rspec'
require 'rest-client'

require File.join(File.dirname(__FILE__), '..', '..', 'app.rb')
require File.join(File.dirname(__FILE__), 'events_labs_helpers.rb')
require File.join(File.dirname(__FILE__), '..', '..', 'rest-assured','helpers.rb')

include RestAssuredHelpers
start_test_api

Capybara.app = Application

# No cacheing for Cukes!
Capybara.app.set :cache, nil

class ApplicationWorld
  include Capybara::DSL
  include RSpec::Expectations
  include RSpec::Matchers
end

World(EventsLabsHelpers)

World do
  ApplicationWorld.new
end
