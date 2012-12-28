Feature: Example elements can be modeled.


  Acceptance criteria

  All conceptual pieces of an Examples block can be modeled:
    1. the examples' name
    2. the examples' description
    3. the examples' parameters
    4. the examples' rows
    5. the examples' tags


  Background: Test file setup.
    Given the following feature file:
    """
    @a_feature_level_tag
    Feature: The test feature name.

      @outline_tag
      Scenario Outline: The scenario outline's name.
        Given this *parameterized* step takes a table:
          | <param1> |
          | <param2> |
        Then I don't really need another step

      Examples: text describing the significance of the examples
          Anything besides the | that starts a row should be valid
          description at this point in the test. YMMV
        | param1 | param2 | extra param |
        #A more random comment
        | x      | y      |      ?      |
        | 1      | 2      |      3      |
        @example_tag @another_one
      Examples: some examples with different significance and a tag

        Words, words, words, words,

         why so many words?
         #

        | param1 |
        #

        #
        | a      |
      Examples:
    """
    And parameter delimiters of "*" and "*"
    When the file is read


  Scenario: The examples' name is modeled.
    Then the test example block "1" is found to have the following properties:
      | name | text describing the significance of the examples |
    And the test example block "2" is found to have the following properties:
      | name | some examples with different significance and a tag |
    And the test example block "3" is found to have the following properties:
      | name |  |


  Scenario: The examples' description is modeled.
    Then the test example block "1" descriptive lines are as follows:
      | Anything besides the \| that starts a row should be valid |
      | description at this point in the test. YMMV               |
    And the test example block "2" descriptive lines are as follows:
      | Words, words, words, words, |
      | why so many words?          |
    And the test example block "3" has no descriptive lines

  Scenario: The examples' tags are modeled.
    Then the test example block "1" has no tags
    And the test example block "2" is found to have the following tags:
      | @example_tag |
      | @another_one |
    And the test example block "3" has no tags


  Scenario: The examples' parameters are modeled.
    Then the test example block "1" parameters are as follows:
      | param1      |
      | param2      |
      | extra param |
    And the test example block "2" parameters are as follows:
      | param1 |
    And the test example block "3" has no parameters


  Scenario: The examples' rows are modeled.
    Then the test example block "1" rows are as follows:
      | x,y,? |
      | 1,2,3 |
    And the test example block "2" rows are as follows:
      | a |
    And the test example block "3" has no rows
