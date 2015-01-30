Feature: Create Contact
  As a Partner
  I want the contacts I created via EPP synced to Registry

  Scenario: Successfully sync contact
    Given partner creates a new contact via EPP
    When  system syncs latest created contacts to Registry
    Then  response from Registry is success

  Scenario: Registry is unavailable
    Given Registry is unavailable
    And   partner creates a new contact via EPP
    When  system syncs latest created contacts to Registry
    Then  sync must time out

  Scenario: Registry rejects sync with invalid field values
    Given partner creates a new contact via EPP
    When  system syncs latest created contacts with invalid field values
    Then  response from Registry must be validation failure

  Scenario: Registry rejects sync with incomplete fields
    Given partner creates a new contact via EPP
    When  system syncs latest created contacts with incomplete fields
    Then  response from Registry must be bad request
