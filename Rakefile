require 'rspec/core/rake_task'
require 'cucumber'
require 'cucumber/rake/task'

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

begin
  require 'jasmine'
  load 'jasmine/tasks/jasmine.rake'
rescue LoadError
  desc "Run jasmine specs"
  task :jasmine do
    abort "Jasmine is not available. In order to run jasmine, you must: (sudo) gem install jasmine"
  end
end
