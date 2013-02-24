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

      Background:Some general test setup stuff.
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
        When some setup step
        But some setup step
#
        Then a step with a *parameter*
        And some big setup step:
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
      | My big hunk of perfectly valid description:                       |
      | \|                                                                |
      | Scenario Outline                                                  |
      | Examples                                                          |
      | """                                                               |
      | Background                                                        |
      | this is still one big valid description                           |

  Scenario: The background steps are modeled.
    Then the background's steps are as follows:
      | Given this *parameterized* step takes a table: |
      | \| data      \|                                |
      | \| more data \|                                |
      | When some setup step                           |
      | But some setup step                            |
      | Then a step with a *parameter*                 |
      | And some big setup step:                       |
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
      | * *lots* *of* *parameters*                     |
    And the background's steps "without" arguments are as follows:
      | Given this ** step takes a table: |
      | When some setup step              |
      | But some setup step               |
      | Then a step with a **             |
      | And some big setup step:          |
      | * ** ** **                        |
    And the background's steps "without" keywords are as follows:
      | this *parameterized* step takes a table: |
      | \| data      \|                          |
      | \| more data \|                          |
      | some setup step                          |
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
      | 'And'                                    |
      | 'But'                                    |
      | '*'                                      |
      | '    some more text'                     |
      | """                                      |
      | *lots* *of* *parameters*                 |
    And the background's steps "without" arguments "without" keywords are as follows:
      | this ** step takes a table: |
      | some setup step             |
      | some setup step             |
      | a step with a **            |
      | some big setup step:        |
      | ** ** **                    |
    And step "1" of the background has the following block:
      | \| data      \| |
      | \| more data \| |
    And step "5" of the background has the following block:
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

  Scenario Outline: Background models pass all other specifications
  Exact specifications detailing the API for Background models.
    Given that there are "<additional specifications>" detailing models
    When the corresponding unit tests are run
    Then all of those specifications are met
  Examples:
    | additional specifications |
    | background_spec.rb        |
