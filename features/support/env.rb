# Generated by cucumber-sinatra. (Mon Sep 03 23:08:46 +0100 2012)

ENV['RACK_ENV'] = 'test'

require File.join(File.dirname(__FILE__), '..', '..', 'routes.rb')
require File.join(File.dirname(__FILE__), 'events_labs_helpers.rb')

require 'capybara'
require 'capybara/cucumber'
require 'rspec'

Capybara.app = Routes 

class ApplicationWorld
  include Capybara::DSL
  include RSpec::Expectations
  include RSpec::Matchers
end

World(EventsLabsHelpers)

World do
  ApplicationWorld.new
end
