Feature: People module
  As a user
  I want to see the actors who had an impact on the story being told 
  So that I can stay informed 

	Background:
    When I go to a News Event page

  Scenario: Viewing a News Event page
    Then I should see the people module

  Scenario: Viewing a list of people on a News Event page
    Then I should see a list of people associated with that event
