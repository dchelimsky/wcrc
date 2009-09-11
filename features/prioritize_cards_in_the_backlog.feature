@wip
Feature: prioritize cards in the backlog
  In order to plan the most valuable work in the next iteration
  As a team leader
  I want to prioritize cards in the backlog

  Scenario: default priority (new cards go to the back)
    Given a "first" card in the backlog
    And a "second" card in the backlog
    Then the "first" card should be higher priority than the "second" card

  Scenario: move a card up in priority
    Given a "first" card in the backlog
    And a "second" card in the backlog
    And the "first" card has higher priority than the "second" card
    When I increase the priority of the "second" card
    Then the "second" card should be higher priority than the "first" card

  Scenario: move a card down in priority
    Given a "first" card in the backlog
    And a "second" card in the backlog
    And the "first" card has higher priority than the "second" card
    When I decrease the priority of the "first" card
    Then the "first" card should be lower priority than the "second" card
