Feature: People module
  As a user
  I want to see the actors who had an impact on the story being told 
  So that I can stay informed 

  Scenario: Viewing an article page
    When I go to an article page
    Then I should see the people module

  Scenario: Viewing an event page
    When I go to an event page
    Then I should see the people module
