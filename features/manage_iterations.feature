@focus
Feature: manage iterations
  In order timebox work
  As a team member
  I want to manage iterations

  Scenario: add new iteration
    Given no iterations
    When I add an iteration with
      | start_date | number_of_days |
      | 9/1/2009   | 7              |
    Then I should see "Iteration 1" starting on "09/01/2009"

  Scenario: add a second iteration
    Given a 7 day iteration beginning "9/1/2009"
    When I add an iteration with
      | start_date | number_of_days |
      | 9/8/2009   | 7              |
    Then I should see "Iteration 1" starting on "09/01/2009"
    And  I should see "Iteration 2" starting on "09/08/2009"

