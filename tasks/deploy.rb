desc "Deploy to Heroku"
task :deploy do
  `git push heroku master`
end
