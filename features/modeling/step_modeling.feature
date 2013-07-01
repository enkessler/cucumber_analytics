Feature: Step elements can be modeled.


  Acceptance criteria

  All conceptual pieces of a Step can be modeled:
    1. the step's keyword
    2. the text of the step
    3. the step's arguments, if any
    4. the step's associated block, if any


  Background: Test file setup.
    Given the following feature file:
    """
    Feature:

      Scenario:
        Given some setup step
        And some big setup step:
        \"\"\" content_type
      some text
            some more text
        \"\"\"
        When this *parameterized* step takes a table:
          | data      | a header |
          | more data | a value  |
        Then a step with a *parameter*
    """
    And parameter delimiters of "*" and "*"
    When the file is read


  Scenario: The step's keyword is modeled.
    Then the test step "1" keyword is "Given"
    And the test step "2" keyword is "And"
    And the test step "3" keyword is "When"
    And the test step "4" keyword is "Then"

  Scenario: The text of the step is modeled.
    Then test step "1" text is "some setup step"
    And test step "2" text is "some big setup step:"
    And test step "3" text is "this *parameterized* step takes a table:"
    And test step "4" text is "a step with a *parameter*"

  Scenario: The step's arguments are modeled.
    Then test step "1" has no arguments
    And test step "2" has no arguments
    And test step "3" arguments are:
      | parameterized |
    And test step "4" arguments are:
      | parameter |

  Scenario: The steps's block is modeled.
    Then step "1" has no block
    Then step "2" has a "doc string"
    And step "3" has a "table"
    And step "4" has no block

  Scenario Outline: Step models pass all other specifications
  Exact specifications detailing the API for Step models.
    Given that there are "<additional specifications>" detailing models
    When the corresponding unit tests are run
    Then all of those specifications are met
  Examples:
    | additional specifications |
    | step_unit_spec.rb         |
    | step_integration_spec.rb  |
