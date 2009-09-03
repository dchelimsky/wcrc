Feature: manage cards
  In order to track stories and features
  As a team member
  I want to manage story cards

  Scenario: add new card
    Given no cards
    When I add a card with
      | title        | description         | points |
      | manage cards | crud ops with cards | 2      |
    Then I should see "1 Card"
    Then I should see the "manage cards" card

  Scenario: add a second card
    Given a "manage cards" card
    When I add a "manage iterations" card
    Then I should see "2 Cards"
    Then I should see the "manage cards" card
    And  I should see the "manage iterations" card

