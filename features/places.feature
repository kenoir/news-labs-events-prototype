Feature: Places module
  As a user
  I want to see the locations which had an impact on the story being told 
  So that I can stay informed 

  Scenario: Viewing an event page
    When I go to an event page
    Then I should see the places module

  Scenario: Viewing a list if places on an event page
    When I go to an event page
    Then I should see a list of places associated with that event
