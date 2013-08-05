Feature: Features can be modeled.


  Acceptance criteria

  All conceptual pieces of a Feature can be modeled:
    1.  the feature's name
    2.  the feature's description
    3.  the feature's tags
    4.  the feature's scenarios
    5.  the feature's outlines
    6.  the feature's background
    7.  the feature's total number of tests
    8.  the feature's total number of test cases
    9.  the feature's source line
    10. the feature's raw element


  Background: Test file setup.
    Given the following feature file "much_stuff.feature":
    """
    @a_feature_level_tag @and_another

     Feature:The test feature name.
      Some feature description.
      And some more.

      Background:Some general test setup stuff.
        * some setup step

      Scenario: The first scenario's name.
      * a step

      Scenario Outline: The scenario outline's name.
        * a step
      Examples:
        | param |
        | x     |
        | y     |
      Examples:
        | param |
        | z     |

      Scenario: The second scenario's name.
        * a step
    """
    And the following feature file "barely_any_stuff.feature":
    """
    Feature:

      Background:

      Scenario:

      Scenario Outline:
      Examples:
    """
    And the following feature file "as_empty_as_it_gets.feature":
    """
    Feature:
    """
    When the file "much_stuff.feature" is read
    And the file "barely_any_stuff.feature" is read
    And the file "as_empty_as_it_gets.feature" is read


  Scenario: The raw feature element is modeled.
    Then the feature correctly stores its underlying implementation

  Scenario: The feature's properties are modeled.
    Then feature "1" is found to have the following properties:
      | name            | The test feature name. |
      | test_count      | 3                      |
      | test_case_count | 5                      |
      | source_line     | 3                      |
    And feature "2" is found to have the following properties:
      | name            |   |
      | test_count      | 2 |
      | test_case_count | 1 |
      | source_line     | 1 |

    And feature "3" is found to have the following properties:
      | name            |   |
      | test_count      | 0 |
      | test_case_count | 0 |
      | source_line     | 1 |

  Scenario: The feature's description is modeled.
    Then the descriptive lines of feature "1" are as follows:
      | Some feature description. |
      | And some more.            |
    And feature "2" has no descriptive lines
    And feature "3" has no descriptive lines

  Scenario: The feature's tags are modeled.
    Then feature "1" is found to have the following tags:
      | @a_feature_level_tag |
      | @and_another         |
    And feature "2" has no tags
    And feature "3" has no tags

  Scenario: The feature's scenarios are modeled.
    Then feature "1" is found to have the following properties:
      | scenario_count | 2 |
    And feature "1" scenarios are as follows:
      | The first scenario's name.  |
      | The second scenario's name. |
    And feature "2" is found to have the following properties:
      | scenario_count | 1 |
    And feature "2" scenarios are as follows:
      |  |
    And feature "3" is found to have the following properties:
      | scenario_count | 0 |
    And feature "3" has no scenarios

  Scenario: The feature's outlines are modeled.
    Then feature "1" is found to have the following properties:
      | outline_count | 1 |
    And feature "1" outlines are as follows:
      | The scenario outline's name. |
    And feature "2" is found to have the following properties:
      | outline_count | 1 |
    And feature "2" outlines are as follows:
      |  |
    And feature "3" is found to have the following properties:
      | outline_count | 0 |
    And feature "3" has no outlines

  Scenario: The feature's background is modeled.
    Then feature "1" is found to have the following properties:
      | has_background? | true |
    And feature "1" background is as follows:
      | Some general test setup stuff. |
    And feature "2" is found to have the following properties:
      | has_background? | true |
    And feature "2" background is as follows:
      |  |
    And feature "3" is found to have the following properties:
      | has_background? | false |
    And feature "3" has no background

  Scenario Outline: Feature models pass all other specifications
  Exact specifications detailing the API for Feature models.
    Given that there are "<additional specifications>" detailing models
    When the corresponding unit tests are run
    Then all of those specifications are met
  Examples:
    | additional specifications   |
    | feature_unit_spec.rb        |
    | feature_integration_spec.rb |
