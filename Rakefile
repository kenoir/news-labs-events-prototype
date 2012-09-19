require 'rspec/core/rake_task'
require 'cucumber'
require 'cucumber/rake/task'
require 'assured-runner'

require_relative 'scripts/link_checker.rb'
require_relative 'tasks/autotest.rb'
require_relative 'tasks/cucumber.rb'
require_relative 'tasks/deploy.rb'
require_relative 'tasks/jasmine.rb'
require_relative 'tasks/link_checker.rb'
require_relative 'tasks/mockapi.rb'
require_relative 'tasks/specs.rb'
require_relative 'tasks/start_app.rb'

desc 'Default: run cukes  & specs.'
task :default => [:features,:spec]
