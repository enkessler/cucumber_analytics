Feature: Example elements can be modeled.


  Acceptance criteria

  All conceptual pieces of an Examples block can be modeled:
    1. the examples' name
    2. the examples' description
    3. the examples' rows
    4. the examples' tags


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
        | param1 | param2 |
        #A more random comment
        | x      | y      |
        @example_tag @another_one
      Examples: some examples with different significance and a tag

        Words, words, words, words,

         why so many words?
         #

        | param1 | param2 |
        #

        #
        | a      | b      |

    """
    And parameter delimiters of "*" and "*"
    When the file is read


  Scenario: The examples' name is modeled.
    Then the test example block "1" is found to have the following properties:
      | name | text describing the significance of the examples |
    And the test example block "2" is found to have the following properties:
      | name | some examples with different significance and a tag |

  Scenario: The examples' description is modeled.
    Then the test example block "1" descriptive lines are as follows:
      | Anything besides the \| that starts a row should be valid |
      | description at this point in the test. YMMV               |
    And the test example block "2" descriptive lines are as follows:
      | Words, words, words, words, |
      | why so many words?          |

  Scenario: The examples' tags are modeled.
    Then the test example block "1" has no tags
    And the test example block "2" is found to have the following tags:
      | @example_tag |
      | @another_one |

  Scenario: The examples' rows are modeled.
    Then the test example block "1" rows are as follows:
      | \| param1 \| param2 \| |
      | \| x      \| y      \| |
    And the test example block "2" rows are as follows:
      | \| param1 \| param2 \| |
      | \| a      \| b      \| |
