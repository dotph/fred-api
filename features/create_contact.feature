Feature: Create Contact
  As a Partner
  I want the contacts I created via EPP synced to Registry

  Background:
    Given system just completed syncing records

  Scenario: Successfully sync latest created contacts
    Given partner creates a new contact via EPP
    When  system syncs latest created contacts
    Then  latest created contacts must be synced

  Scenario: Registry is unavailable
    Given Registry is unavailable
    And   partner creates a new contact via EPP
    When  system syncs latest created contacts
    Then  sync must time out

  Scenario Outline: Registry rejects invalid syncs
    Given partner creates a new contact via EPP
    When  system syncs latest created contacts with <invalid request>
    Then  sync must raise <error message>

    Examples:
      | invalid request                     | error message         |
      | invalid field values                | validation failed     |
      | incomplete fields                   | bad request           |
      | empty request                       | bad request           |
      | invalid authentication credentials  | authentication failed |

  Scenario: Exclude contacts that were already synced
    Given partner created contacts and were already synced
    When  system syncs latest created contacts
    Then  no contacts must be synced
