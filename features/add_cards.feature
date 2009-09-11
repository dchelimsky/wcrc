Feature: add cards
  In order to track stories and features
  As a team member
  I want to add story cards

  Scenario: add new card
    Given no cards
    When I add a card with
      | title        | description         | points |
      | manage cards | crud ops with cards | 2      |
    Then I should see the "manage cards" card in the backlog

  Scenario: add a second card
    Given a "manage cards" card
    When I add a "manage iterations" card
    Then I should see the "manage cards" card in the backlog
    And  I should see the "manage iterations" card in the backlog

