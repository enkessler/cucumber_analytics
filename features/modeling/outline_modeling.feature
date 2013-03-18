Feature: Scenario Outline elements can be modeled.


  Acceptance criteria

  All conceptual pieces of a Scenario Outline can be modeled:
    1. the outline's name
    2. the outline's description
    3. the outline's steps
    4. the outline's tags
    5. the outline's applied tags
    6. the outline's example blocks


  Background: Test file setup.
    Given the following feature file:
    """
    @a_feature_level_tag
    Feature: The test feature name.
      Some more feature description.

      @outline_tag
      Scenario Outline:The scenario outline's name.
        My big hunk of perfectly valid description:
          |

          Scenario Outline
          Examples
          \"\"\"
          Background
           this is still one big valid description
          # Basically, if it's not a step keyword or tag then I will accept
          # it as description here. Cucumber might not but but that's between
          # you and its lexxer/parser. ;)

        Given this *parameterized* step takes a table:
          | <param1> |
          | <param2> |
        And some setup step
        * some setup step
#
        When a step with a *parameter*
        But a big step:
        #random comment
        \"\"\"
      some text

        #some comments
        Scenario:
        Scenario Outline:
        Examples:
        @
        Feature:
        |
        Given
        When
        Then
        And
        But
        *
            some more text
        \"\"\"
        Then *lots* *of* *parameters*

      Examples:text describing the significance of the examples
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


  Scenario: The outline name is modeled.
    Then the test is found to have the following properties:
      | name | The scenario outline's name. |

  Scenario: The outline description is modeled.
    Then the test descriptive lines are as follows:
      | My big hunk of perfectly valid description: |
      | \|                                          |
      | Scenario Outline                            |
      | Examples                                    |
      | """                                         |
      | Background                                  |
      | this is still one big valid description     |

  Scenario: The outline steps are modeled.
    Then the test steps are as follows:
      | this *parameterized* step takes a table: |
      | some setup step                          |
      | some setup step                          |
      | a step with a *parameter*                |
      | a big step:                              |
      | *lots* *of* *parameters*                 |

  Scenario: The outline tags are modeled.
    Then the test is found to have the following tags:
      | @outline_tag |

  Scenario: The outline applied tags are modeled.
    Then the test is found to have the following applied tags:
      | @a_feature_level_tag |

  Scenario: The outline example blocks are modeled.
    And the test example blocks are as follows:
      | text describing the significance of the examples    |
      | some examples with different significance and a tag |

  Scenario Outline: Outline models pass all other specifications
  Exact specifications detailing the API for Scenario Outline models.
    Given that there are "<additional specifications>" detailing models
    When the corresponding unit tests are run
    Then all of those specifications are met
  Examples:
    | additional specifications |
    | outline_spec.rb           |
