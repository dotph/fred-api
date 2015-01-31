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
