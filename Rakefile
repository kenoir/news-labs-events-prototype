require 'rspec/core/rake_task'
require 'cucumber'
require 'cucumber/rake/task'
require 'assured-runner'

desc 'Start REST-Assured (Mock API)'
task :mockapi do
  Thread.new { AssuredRunner.run }
end

desc 'Default: run cukes  & specs.'
task :default => [:features,:spec]

desc "Run cukes"
Cucumber::Rake::Task.new(:features) do |t|
  t.cucumber_opts = "features --format pretty"
end

desc "Run specs"
RSpec::Core::RakeTask.new do |t|
  t.pattern = "./spec/**/*_spec.rb" 
end

desc "Run autotest"
task :autotest do 
  system 'autotest' 
end 

desc "Run app with RACK_ENV set to 'production', and REST_PROXY set to reith"
task :start_production do
  system 'foreman start --env config/foreman/dev_with_live_api.env'
end

desc "Run app with RACK_ENV set to development, also starts mock API"
task :start_development => :mockapi do
  system 'foreman start --env config/foreman/dev_with_mockapi.env'
end

begin
  require 'jasmine'
  load 'jasmine/tasks/jasmine.rake'
rescue LoadError
  desc "Run jasmine specs"
  task :jasmine do
    abort "Jasmine is not available. In order to run jasmine, you must: (sudo) gem install jasmine"
  end
end
