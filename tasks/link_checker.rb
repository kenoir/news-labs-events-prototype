desc "Check events links on http://news-labs-events-prototype.herokuapp.com/"
task :link_checker do
  if not ENV['http_proxy'].nil?
    ENV['REST_PROXY'] = ENV['http_proxy']
  end

  LinkChecker.all_ok?
end
