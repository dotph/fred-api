Feature: Register Domain
  As a Partner
  I want the domains I registered via EPP synced to Registry

  Background:
    Given system just completed syncing records

  Scenario: Successfully sync latest registerd domains
    Given partner registers a domain via EPP
    When  system syncs latest registered domains
    Then  latest registered domains must be synced

  Scenario: Registry is unavailable
    Given Registry is unavailable
    And   partner registers a domain via EPP
    When  system syncs latest registered domains
    Then  sync must time out

  Scenario Outline: Registry rejects invalid syncs
    Given partner registers a domain via EPP
    When  system syncs latest registered domains with <invalid request>
    Then  sync must raise <error message>

    Examples:
      | invalid request                     | error message         |
      | invalid field values                | validation failed     |
      | incomplete fields                   | bad request           |
      | empty request                       | bad request           |
      | invalid authentication credentials  | authentication failed |
