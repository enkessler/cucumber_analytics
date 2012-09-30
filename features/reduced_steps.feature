Feature: Feature elements with steps can provide them without arguments.


  Background: Test file setup.
    Given the following feature file:
    """
    Feature: The test feature name.

      Background: Some general test setup stuff.
        Given a defined step
        And a step with a *parameter*
        And *lots* *of* *parameters*

      Scenario: The scenario's name.
        Given a defined step
        And a step with a *parameter*
        And *lots* *of* *parameters*

      Scenario Outline: The scenario outline's name.
        Given a defined step
        And a step with a *parameter*
        And *<param1>* *of* *<param2>*
      Examples:
        | param1 | param2 |
        | x      | y      |
      Examples:
        | param1 | param2 |
        | a      | b      |
    """
    And parameter delimiters of "*" and "*"
    When the file is parsed

  Scenario: Backgrounds can extract stripped steps
    Then the background's stripped steps "with" keywords are as follows:
      | Given a defined step |
      | And a step with a ** |
      | And ** ** **         |
    Then the background's stripped steps "without" keywords are as follows:
      | a defined step   |
      | a step with a ** |
      | ** ** **         |

  Scenario: Scenarios can extract stripped steps
    Then scenario "1" stripped steps "with" keywords are as follows:
      | Given a defined step |
      | And a step with a ** |
      | And ** ** **         |
    Then scenario "1" stripped steps "without" keywords are as follows:
      | a defined step   |
      | a step with a ** |
      | ** ** **         |

  Scenario: Outlines can extract stripped steps
    Then scenario "2" stripped steps "with" keywords are as follows:
      | Given a defined step |
      | And a step with a ** |
      | And ** ** **         |
    Then scenario "2" stripped steps "without" keywords are as follows:
      | a defined step   |
      | a step with a ** |
      | ** ** **         |
