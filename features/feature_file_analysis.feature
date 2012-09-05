Feature: The gem has the ability to lex a .feature file and extract various
  pieces of information from it.

  Background: Test file setup.
    Given the following feature file:
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
    When the file is parsed

  Scenario: The parser can extract various information about the feature.
    Then the feature is found to have the following properties:
      | name           | The test feature name.                                                         |
      | scenario_count | 3                                                                              |
      | test_count     | 4                                                                              |
      | outline_count  | 1                                                                              |
      | file           | C:\devl\repos\cucumber-analytics\features\support\..\test_files\test_file.feature |

  Scenario: The parser can extract a feature's description.
    Then the feature's descriptive lines are as follows:
      | Some more feature description. |
      | And some more.                 |

  Scenario: The parser can extract a feature's tags
    Then the feature is found to have the following tags:
      | @a_feature_level_tag |
      | @and_another         |
      | @and_another         |
