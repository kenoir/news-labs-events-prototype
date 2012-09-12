Then /^I should see the latest articles module$/ do
  page_should_have_latest_articles_module
end

Then /^I should see a list of latest articles associated with that event$/ do
  latest_article_module_should_have_list_of_articles
end

Then /^I should see a list of latest articles within the person module for each person$/ do
    pending # express the regexp above with the code you wish you had
end
