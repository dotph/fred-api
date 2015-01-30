Feature: Create Contact
  As a Partner
  I want the contacts I created via EPP synced to Registry

  Scenario: Successfully sync contact
    Given partner creates a new contact via EPP
    When  system syncs latest created contacts to Registry
    Then  response from Registry is success
