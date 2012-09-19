desc "Run app with RACK_ENV set to 'production', and REST_PROXY set to reith"
task :start_production do
  `foreman start --env config/foreman/dev_with_live_api.env`
end

desc "Run app with RACK_ENV set to development, also starts mock API"
task :start_development => :mockapi do
  `foreman start --env config/foreman/dev_with_mockapi.env`
end
