Feature: Event page 
  As a user 
  I want to see information about a news event 
  So that I can see the background info for a story 

  Background:
    When I go to an event page 

  Scenario: Visiting an event page 
    Then I should see an event page 
  
  Scenario: Viewing people related to an event
    Then I should see a list of people involved in that event 

  Scenario: Viewing places related to an event
    Then I should see a list of places involved in that event 
