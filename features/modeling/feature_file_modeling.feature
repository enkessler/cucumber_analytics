Feature: Feature files can be lexed.
  A .feature file can be broken down into its component parts for further
  analysis. Even if there isn't anything worth breaking down...

  Background: Test file setup.
    Given the following feature file "much_stuff.feature":
    """
    #Don't mind me.
    #Or any line that is a comment, really.
    @a_feature_level_tag @and_another@and_another

    Feature: The test feature name.
      Some more feature description.
      And some more.

      Background: Some general test setup stuff.
        A little more information.
        * some setup step

      @a_tag

      @another_tag@yet_another_tag
      Scenario: The first scenario's name.
        Some text describing the scenario.
        More text.
        Given the first step
        When the second step
        Then the third step
    #Random comment
      @outline_tag
      Scenario Outline: The scenario outline's name.
        Some text describing the scenario.
        More text.
        Given the first "<param1>"
        When the second "<param2>"
        Then the third step
      Examples: text describing the significance of the examples
        | param1 | param2 |
        #A more random comment
        | x      | y      |
        @example_tag
      Examples: some examples with different significance and a tag
        | param1 | param2 |
        | a      | b      |


      Scenario: The second scenario's name.
        Some text describing the scenario.
        More text.
        Given the first step
        When the second step
        Then the third step

    """
    And the following feature file "barely_any_stuff.feature":
    """
    Feature:

      Background:

      Scenario:

      Scenario Outline:
      Examples:
    """
    When the file "much_stuff.feature" is parsed
    And the file "barely_any_stuff.feature" is parsed


  Scenario: The parser can extract various information about the feature.
    Then feature "1" is found to have the following properties:
      | name           | The test feature name. |
      | scenario_count | 2                      |
      | test_count     | 4                      |
      | outline_count  | 1                      |
    And feature "2" is found to have the following properties:
      | name           |   |
      | scenario_count | 1 |
      | test_count     | 1 |
      | outline_count  | 1 |

  Scenario: The parser can extract a feature's description.
    Then the descriptive lines of feature "1" are as follows:
      | Some more feature description. |
      | And some more.                 |
    And feature "2" has no descriptive lines

  Scenario: The parser can extract a feature's tags
    Then feature "1" is found to have the following tags:
      | @a_feature_level_tag |
      | @and_another         |
      | @and_another         |
    And feature "2" has no tags
