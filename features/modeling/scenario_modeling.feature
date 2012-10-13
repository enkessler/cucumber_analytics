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
    #a comment

        Some text describing the scenario.
        More text.
        Given this *parameterized* step takes a table:
          | data      |
          | more data |
        And some setup step
#
        When a step with a *parameter*
        And a big step:
        #random comment
        -"-"-"-
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
        *
            some more text
        -"-"-"-
        Then *lots* *of* *parameters*

    """
    And parameter delimiters of "*" and "*"
    When the file is read


  Scenario: The scenario name is modeled.
    Then the scenario is found to have the following properties:
      | name | The first scenario's name. |

  Scenario: The scenario description is modeled.
    Then the scenario descriptive lines are as follows:
      | Some text describing the scenario. |
      | More text.                         |

  Scenario: The scenario steps are modeled.
    Then the scenario steps are as follows:
      | Given this *parameterized* step takes a table: |
      | \| data      \|                                |
      | \| more data \|                                |
      | And some setup step                            |
      | When a step with a *parameter*                 |
      | And a big step:                                |
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
      | '*'                                            |
      | '    some more text'                           |
      | """                                            |
      | Then *lots* *of* *parameters*                  |
    And the scenario steps "without" arguments are as follows:
      | Given this ** step takes a table: |
      | And some setup step               |
      | When a step with a **             |
      | And a big step:                   |
      | Then ** ** **                     |
    And the scenario steps "without" keywords are as follows:
      | this *parameterized* step takes a table: |
      | \| data      \|                          |
      | \| more data \|                          |
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
      | '*'                                      |
      | '    some more text'                     |
      | """                                      |
      | *lots* *of* *parameters*                 |
    And the scenario steps "without" arguments "without" keywords are as follows:
      | this ** step takes a table: |
      | some setup step             |
      | a step with a **            |
      | a big step:                 |
      | ** ** **                    |
    And the scenario step "1" has the following block:
      | \| data      \| |
      | \| more data \| |
    And the scenario step "4" has the following block:
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
      | '*'                  |
      | '    some more text' |
      | """                  |

  Scenario: The scenario tags are modeled.
    Then the scenario is found to have the following tags:
      | @a_tag           |
      | @another_tag     |
      | @yet_another_tag |
