# Taken from the cucumber-rails project.
module NavigationHelpers
  # Maps a name to a path. Used by the
  #
  #   When /^I go to (.+)$/ do |page_name|
  #
  # step definition in web_steps.rb
  #
  def path_to(page_name)
    case page_name

    when /^a News Article page$/
          '/news/articles/1'

    when /^a K&L Place page$/
          '/learn/places/1'

    when /^a K&L Person page$/
          '/learn/people/1'

    when /^a News Event page$/
          '/news/events/1'

    when /^a K&L Event page$/
          '/learn/events/1'
 
    # Add more mappings here.
    # Here is an example that pulls values out of the Regexp:
    #
    #   when /^(.*)'s profile page$/i
    #     user_profile_path(User.find_by_login($1))

    else
      raise "Can't find mapping from \"#{page_name}\" to a path.\n" +
        "Now, go and add a mapping in #{__FILE__}"
    end
  end
end

World(NavigationHelpers)
