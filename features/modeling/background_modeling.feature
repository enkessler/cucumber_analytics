Feature: Background elements can be modeled.


  Acceptance criteria

  All conceptual pieces of a Background can be modeled:
    1. the background's name
    2. the background's description
    3. the background's steps

  Background: Test file setup.
    Given the following feature file:
    """
    Feature:

      Background:Some general test setup stuff.
          Some background description
          Some more description

        Given a setup step
        And another setup step
        When an action step
    """
    And parameter delimiters of "*" and "*"
    When the file is read


  Scenario: The background name is modeled.
    Then the background is found to have the following properties:
      | name | Some general test setup stuff. |

  Scenario: The background description is modeled.
    Then the background's descriptive lines are as follows:
      | Some background description |
      | Some more description       |

  Scenario: The background steps are modeled.
    Then the background's steps are as follows:
      | a setup step       |
      | another setup step |
      | an action step     |

  Scenario Outline: Background models pass all other specifications
  Exact specifications detailing the API for Background models.
    Given that there are "<additional specifications>" detailing models
    When the corresponding unit tests are run
    Then all of those specifications are met
  Examples:
    | additional specifications      |
    | background_spec.rb             |
    | background_integration_spec.rb |
