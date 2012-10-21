Feature: Background elements can be modeled.


  Acceptance criteria

  All conceptual pieces of a Background can be modeled:
    1. the background's name
    2. the background's description
    3. the background's steps

  Background: Test file setup.
    Given the following feature file:
    """
    Feature: The test feature name.
      Some more feature description.

      Background: Some general test setup stuff.
      #unimportant text
      #   more of the same
        A little more information.


        * this *parameterized* step takes a table:
          | data      |
          | more data |
        * some setup step
#
        * a step with a *parameter*
        * some big setup step:
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
        *
            some more text
        \"\"\"
        * *lots* *of* *parameters*


      Scenario: The first scenario's name.
        Given the first step
        When the second step
        Then the third step
    """
    And parameter delimiters of "*" and "*"
    When the file is read


  Scenario: The background name is modeled.
    Then the background is found to have the following properties:
      | name | Some general test setup stuff. |

  Scenario: The background description is modeled.
    Then the background's descriptive lines are as follows:
      | A little more information. |

  Scenario: The background steps are modeled.
    Then the background's steps are as follows:
      | * this *parameterized* step takes a table: |
      | \| data      \|                            |
      | \| more data \|                            |
      | * some setup step                          |
      | * a step with a *parameter*                |
      | * some big setup step:                     |
      | """                                        |
      | 'some text'                                |
      | ''                                         |
      | '#some comments'                           |
      | 'Scenario:'                                |
      | 'Scenario Outline:'                        |
      | 'Examples:'                                |
      | '@'                                        |
      | 'Feature:'                                 |
      | '\|'                                       |
      | 'Given'                                    |
      | 'When'                                     |
      | 'Then'                                     |
      | '*'                                        |
      | '    some more text'                       |
      | """                                        |
      | * *lots* *of* *parameters*                 |
    And the background's steps "without" arguments are as follows:
      | * this ** step takes a table: |
      | * some setup step             |
      | * a step with a **            |
      | * some big setup step:        |
      | * ** ** **                    |
    And the background's steps "without" keywords are as follows:
      | this *parameterized* step takes a table: |
      | \| data      \|                          |
      | \| more data \|                          |
      | some setup step                          |
      | a step with a *parameter*                |
      | some big setup step:                     |
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
    And the background's steps "without" arguments "without" keywords are as follows:
      | this ** step takes a table: |
      | some setup step             |
      | a step with a **            |
      | some big setup step:        |
      | ** ** **                    |
    And step "1" of the background has the following block:
      | \| data      \| |
      | \| more data \| |
    And step "4" of the background has the following block:
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
