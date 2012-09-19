@big 
Feature: Reliability using live API
  As a developer
  I want to make sure the application works with all live Event data
  So that I can provide a reliable experience to the user

  Scenario: Visiting all event pages
    Given I have a list of available events
    When a request is made to each event
    Then each request is successful
