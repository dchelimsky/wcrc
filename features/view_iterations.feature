Feature: view iterations
  In order to get a sense of the layout of my project
  As a team member
  I want to view the iterations and the cards in them
  
  Scenario: One iteration with one card
    Given a "manage cards" card in the iteration starting "9/12/2009"
    When I go to the iterations page
    Then I should see the "manage cards" card in the iteration starting "9/12/2009"

@focus
  Scenario: move card to another iteration
    Given an iteration starting "9/12/2009"
    And an iteration starting "9/19/2009"
    And a "manage cards" card in the iteration starting "9/12/2009"
    And I am on the iterations page
    When I move the "manage cards" card to the iteration starting "09/19/2009"
    Then I should not see the "manage cards" card in the iteration starting "09/12/2009"
    And I should see the "manage cards" card in the iteration starting "09/19/2009"
