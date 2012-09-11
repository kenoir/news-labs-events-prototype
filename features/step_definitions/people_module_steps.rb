Then /^I should see the people module$/ do
  page_should_have_people_module
end

Then /^I should see a list of people associated with that event$/ do
  people_module_should_have_list_of_people
end
