Feature: Doc strings are parsed correctly.

  Background: Test file setup.
    Given a directory "../test_files"
    When the file "doc_string_test_file.feature" is parsed

  Scenario: Backgrounds can handle doc strings.
    Then the background's steps "with" keywords are as follows:
      | * some big setup step: |
      | """                    |
      | 'some text'            |
      | ''                     |
      | '#some comments'       |
      | 'Scenario:'            |
      | 'Scenario Outline:'    |
      | 'Examples:'            |
      | '@'                    |
      | 'Feature:'             |
      | '\|'                   |
      | 'Given'                |
      | 'When'                 |
      | 'Then'                 |
      | '*'                    |
      | '    some more text'   |
      | """                    |
      | * some setup step      |

  Scenario: Scenarios can handle doc strings.
    Then scenario "1" steps "with" keywords are as follows:
      | Given the first step |
      | When a big step:     |
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
      | Then the third step  |

  Scenario: Outlines can handle doc strings.
    Then scenario "2" steps "with" keywords are as follows:
      | Given the first "<param1>" |
      | When a big step:           |
      | """                        |
      | 'some text'                |
      | ''                         |
      | '#some comments'           |
      | 'Scenario:'                |
      | 'Scenario Outline:'        |
      | 'Examples:'                |
      | '@'                        |
      | 'Feature:'                 |
      | '\|'                       |
      | 'Given'                    |
      | 'When'                     |
      | 'Then'                     |
      | '*'                        |
      | '    some more text'       |
      | """                        |
      | When the second "<param2>" |
      | Then the third step        |
