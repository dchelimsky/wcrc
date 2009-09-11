Feature: view iterations
  In order to get a sense of the layout of my project
  As a team member
  I want to view the iterations and the cards in them

  Scenario: One iteration with no cards, one card in the backlog
    Given a "manage cards" card
    When I go to the iterations page
    Then I should see the "manage cards" card in the backlog

@focus
  Scenario: One iteration with one card
    Given a "manage cards" card in the iteration starting "9/12/2009"
    When I go to the iterations page
    Then I should see the "manage cards" card in the iteration starting "9/12/2009"
    And I should not see any cards in the backlog

  Scenario: move card to another iteration
    Given an iteration starting "9/12/2009"
    And an iteration starting "9/19/2009"
    And a "manage cards" card in the iteration starting "9/12/2009"
    And I am on the iterations page
    When I move the "manage cards" card to the iteration starting "09/19/2009"
    Then I should not see the "manage cards" card in the iteration starting "09/12/2009"
    And I should see the "manage cards" card in the iteration starting "09/19/2009"

  Scenario: navigate to card
    Given an iteration starting "9/12/2009"
    And a card with
      | title        | description         | points | iteration |
      | manage cards | crud ops with cards | 2      | 9/12/2009 |
    And I am on the iterations page
    When I follow "manage cards"
    Then I should see detailed information for the "manage cards" card

  Scenario: moving a card out of the backlog
    Given an iteration starting "9/1/2009"
    And a "manage cards" card
    When I go to the iterations page
    And I move the "manage cards" card to the iteration starting "09/01/2009"
    Then I should see the "manage cards" card in the iteration starting "09/01/2009"
    And I should not see the "manage cards" card in the backlog
