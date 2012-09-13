Then /^I should see the places module$/ do
  page_should_have_places_module
end

Then /^I should see a list of places associated with that event$/ do
  places_module_should_have_list_of_people
end

