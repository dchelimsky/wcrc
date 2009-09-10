Feature: view iterations
  In order to get a sense of the layout of my project
  As a team member
  I want to view the iterations and the cards in them
  
@focus
  Scenario: One iteration with one card
    Given a "managed cards" card in the iteration starting "9/12/2009"
    When I go to the iterations page
    Then I should see the "managed cards" card in the iteration starting "9/12/2009"
