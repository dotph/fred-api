Feature: Create Contact
  As a Partner
  I want the contacts I created via EPP synced to Registry

  Scenario: Successfully sync contact
    Given partner creates a new contact via EPP
    When  system syncs latest created contacts
    Then  response from Registry is success

  Scenario: Registry is unavailable
    Given Registry is unavailable
    And   partner creates a new contact via EPP
    When  system syncs latest created contacts
    Then  sync must time out

  Scenario Outline: Registry rejects invalid syncs
    Given partner creates a new contact via EPP
    When  system syncs latest created contacts with <invalid request>
    Then  response from Registry must be <error message>

    Examples:
      | invalid request       | error message     |
      | invalid field values  | validation failed |
      | incomplete fields     | bad request       |
      | empty request         | bad request       |

  @wip
  Scenario: Exclude contacts that were already synced
    Given partner created contacts and were already synced
    When  system syncs latest created contacts
    Then  no contacts must be synced
