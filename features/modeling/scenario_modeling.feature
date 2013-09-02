Feature: Scenario elements can be modeled.


  Acceptance criteria

  All conceptual pieces of a Scenario can be modeled:
    1. the scenario's name
    2. the scenario's description
    3. the scenario's steps
    4. the scenario's tags
    5. the scenario's applied tags
    6. the scenario's source line
    7. the scenario's raw element


  Background: Test file setup.
    Given the following feature file:
    """
    @a_feature_level_tag
    Feature:

      @a_tag
      @another_tag
      Scenario:The first scenario's name.
          Some scenario description
          Some more description

        Given a setup step
        When an action step
        Then a verification step
    """
    And parameter delimiters of "*" and "*"
    When the file is read


  Scenario: The raw scenario element is modeled.
    Then the test correctly stores its underlying implementation

  Scenario: The scenario source line is modeled.
    Then the test is found to have the following properties:
      | source_line | 6 |

  Scenario: The scenario name is modeled.
    Then the test is found to have the following properties:
      | name | The first scenario's name. |

  Scenario: The scenario description is modeled.
    Then the test descriptive lines are as follows:
      | Some scenario description |
      | Some more description     |

  Scenario: The scenario steps are modeled.
    Then the test steps are as follows:
      | a setup step        |
      | an action step      |
      | a verification step |

  Scenario: The scenario tags are modeled.
    Then the test is found to have the following tags:
      | @a_tag       |
      | @another_tag |

  Scenario: The scenario applied tags are modeled.
    Then the test is found to have the following applied tags:
      | @a_feature_level_tag |

  Scenario Outline: Scenario models pass all other specifications
  Exact specifications detailing the API for Scenario models.
    Given that there are "<additional specifications>" detailing models
    When the corresponding specifications are run
    Then all of those specifications are met
  Examples:
    | additional specifications    |
    | scenario_unit_spec.rb        |
    | scenario_integration_spec.rb |
