Feature: Background elements can be modeled.


  Acceptance criteria

  All conceptual pieces of a Background can be modeled:
    1. the background's name
    2. the background's description
    3. the background's steps
    4. the background's source line
    5. the background's raw element

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


  Scenario: The raw background element is modeled.
    Then the background correctly stores its underlying implementation

  Scenario: The background source line is modeled.
    Then the background is found to have the following properties:
      | source_line | 3 |

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
    When the corresponding specifications are run
    Then all of those specifications are met
  Examples:
    | additional specifications      |
    | background_unit_spec.rb        |
    | background_integration_spec.rb |
