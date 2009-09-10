Feature: view backlog
  In order to keep track of stories that are not assigned to iterations
  As a team member
  I want to view the backlog

  Scenario: one unassigned card
    Given a "manage cards" card
    When I go to the backlog
    Then I should see the "manage cards" card

  Scenario: two cards, one assigned, one unassigned
    Given a 7 day iteration beginning "9/1/2009"
    And a "manage cards" card in iteration starting "9/1/2009"
    And a "manage iterations" card
    When I go to the backlog
    Then I should see the "manage iterations" card
    And I should not see the "manage cards" card

  Scenario: moving a card out of the backlog
    Given a 7 day iteration beginning "9/1/2009"
    And a "manage cards" card
    When I go to the backlog
    And I assign the "manage cards" card to the iteration starting "09/01/2009"
    Then I should not see the "manage cards" card
    
    
    
    