require 'rspec/core/rake_task'
require 'cucumber'
require 'cucumber/rake/task'
require 'assured-runner'

require_relative 'scripts/link_checker.rb'

Dir.glob("tasks/*.rb").each do |path|
      import path                
end

desc 'Default: run cukes  & specs.'
task :default => [:features,:spec]
