desc 'Start REST-Assured (Mock API)'
task :mockapi do
  Thread.new { AssuredRunner.run }
end
