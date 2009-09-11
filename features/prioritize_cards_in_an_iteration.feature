Feature: prioritize cards in an iteration
  In order to do the most valuable work next
  As a team leader
  I want to prioritize cards within an iteration

@focus
  Scenario: default priority (new cards go to the back)
    Given a "first" card in the iteration starting "9/12/2009"
    And a "second" card in the backlog
    When I move the "second" card to the iteration starting "9/12/2009"
    Then the "second" card should be lower priority than the "first" card

  Scenario: move a card up in priority
    Given a "first" card in the iteration starting "9/12/2009"
    And a "second" card in the iteration starting "9/12/2009"
    And the "first" card has higher priority than the "second" card
    When I increase the priority of the "second" card
    Then the "second" card should be higher priority than the "first" card

  Scenario: move a card down in priority
    Given a "first" card in the iteration starting "9/12/2009"
    And a "second" card in the iteration starting "9/12/2009"
    And the "first" card has higher priority than the "second" card
    When I decrease the priority of the "first" card
    Then the "first" card should be lower priority than the "second" card
