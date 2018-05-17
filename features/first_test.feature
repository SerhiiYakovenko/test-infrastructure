Feature: Simple Google search test
  Everybody wants to search in Google

  Scenario: Google search
    Given I visit Google homepage
    When I search for some data
    Then I see results