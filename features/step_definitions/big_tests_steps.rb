include EventsLabsHelpers 

Given /^I have a list of available events$/ do
  @available_events = BigTestsHelper.all_available_events
end

When /^a request is made to each event$/ do
  @responses = BigTestsHelper.visit_events(@available_events)
end

Then /^each request is successful$/ do
  pending # express the regexp above with the code you wish you had
end

