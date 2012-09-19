begin
  require 'cucumber'           
  require 'cucumber/rake/task' 

  Cucumber::Rake::Task.new(:features, "Run Cukes") do |t|

  end
rescue LoadError               
  desc 'Cucumber rake task not available'
  task :features do            
    abort 'Cucumber rake task is not available. Be sure to install cucumber as a gem or plugin' 
  end
end
