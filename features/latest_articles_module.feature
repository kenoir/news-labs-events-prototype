Feature: Latest articles
  As a user
  I want to see the latest articles associated with an event
  So that I can stay informed

	Background:
    When I go to a News Event page

  Scenario: Viewing an event page
    Then I should see the latest articles module

  Scenario: Viewing a list of latest articles on an event page
    Then I should see a list of latest articles associated with that event

  Scenario: Viewing the latest articles within a person module
    Then I should see a list of latest articles within the person module for each person
