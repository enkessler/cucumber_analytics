Feature: Scenario elements can be modeled.


  Acceptance criteria

  All conceptual pieces of a Scenario can be modeled:
    1. the scenario's name
    2. the scenario's description
    3. the scenario's steps
    4. the scenario's tags


  Background: Test file setup.
    Given the following feature file:
    """
    @a_feature_level_tag
    Feature: The test feature name.
      Some more feature description.

      @a_tag

      @another_tag@yet_another_tag
      Scenario: The first scenario's name.
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
          | data      |
          | more data |
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

    """
    And parameter delimiters of "*" and "*"
    When the file is read


  Scenario: The scenario name is modeled.
    Then the test is found to have the following properties:
      | name | The first scenario's name. |

  Scenario: The scenario description is modeled.
    Then the test descriptive lines are as follows:
      | My big hunk of perfectly valid description: |
      | \|                                          |
      | Scenario Outline                            |
      | Examples                                    |
      | """                                         |
      | Background                                  |
      | this is still one big valid description     |

  Scenario: The scenario steps are modeled.
    Then the test steps are as follows:
      | Given this *parameterized* step takes a table: |
      | \| data      \|                                |
      | \| more data \|                                |
      | And some setup step                            |
      | * some setup step                              |
      | When a step with a *parameter*                 |
      | But a big step:                                |
      | """                                            |
      | 'some text'                                    |
      | ''                                             |
      | '#some comments'                               |
      | 'Scenario:'                                    |
      | 'Scenario Outline:'                            |
      | 'Examples:'                                    |
      | '@'                                            |
      | 'Feature:'                                     |
      | '\|'                                           |
      | 'Given'                                        |
      | 'When'                                         |
      | 'Then'                                         |
      | 'And'                                          |
      | 'But'                                          |
      | '*'                                            |
      | '    some more text'                           |
      | """                                            |
      | Then *lots* *of* *parameters*                  |
    And the test steps "without" arguments are as follows:
      | Given this ** step takes a table: |
      | And some setup step               |
      | * some setup step                 |
      | When a step with a **             |
      | But a big step:                   |
      | Then ** ** **                     |
    And the test steps "without" keywords are as follows:
      | this *parameterized* step takes a table: |
      | \| data      \|                          |
      | \| more data \|                          |
      | some setup step                          |
      | some setup step                          |
      | a step with a *parameter*                |
      | a big step:                              |
      | """                                      |
      | 'some text'                              |
      | ''                                       |
      | '#some comments'                         |
      | 'Scenario:'                              |
      | 'Scenario Outline:'                      |
      | 'Examples:'                              |
      | '@'                                      |
      | 'Feature:'                               |
      | '\|'                                     |
      | 'Given'                                  |
      | 'When'                                   |
      | 'Then'                                   |
      | 'And'                                    |
      | 'But'                                    |
      | '*'                                      |
      | '    some more text'                     |
      | """                                      |
      | *lots* *of* *parameters*                 |
    And the test steps "without" arguments "without" keywords are as follows:
      | this ** step takes a table: |
      | some setup step             |
      | some setup step             |
      | a step with a **            |
      | a big step:                 |
      | ** ** **                    |
    And the test step "1" has the following block:
      | \| data      \| |
      | \| more data \| |
    And the test step "5" has the following block:
      | """                  |
      | 'some text'          |
      | ''                   |
      | '#some comments'     |
      | 'Scenario:'          |
      | 'Scenario Outline:'  |
      | 'Examples:'          |
      | '@'                  |
      | 'Feature:'           |
      | '\|'                 |
      | 'Given'              |
      | 'When'               |
      | 'Then'               |
      | 'And'                |
      | 'But'                |
      | '*'                  |
      | '    some more text' |
      | """                  |

  Scenario: The scenario tags are modeled.
    Then the test is found to have the following tags:
      | @a_tag           |
      | @another_tag     |
      | @yet_another_tag |
