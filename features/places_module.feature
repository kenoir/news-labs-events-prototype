Feature: Places module
  As a user
  I want to see the locations which had an impact on the story being told 
  So that I can stay informed 

	Background:
    When I go to a News Event page

  Scenario: Viewing a News Event page
    Then I should see the places module

  Scenario: Viewing a list if places on a News Event page
    Then I should see a list of places associated with that event
