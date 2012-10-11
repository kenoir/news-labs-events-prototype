Then /^I should see a News Event page$/ do
  page_should_be_valid_news_events_page
end

Then /^I should see a K&L Event page$/ do
  page_should_be_a_valid_knl_events_page
end

Then /^I should see a News Article page$/ do
    page_should_be_a_valid_news_article_page
end

Then /^I should see a K&L Person page$/ do
    pending # express the regexp above with the code you wish you had
end

Then /^I should see a K&L Place page$/ do
    pending# express the regexp above with the code you wish you had
end
