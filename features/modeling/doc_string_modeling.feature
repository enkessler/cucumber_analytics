Feature: Doc String elements can be modeled.


  Acceptance criteria

  All conceptual pieces of a Doc String can be modeled:
    1. the doc string's content type
    2. the doc string's contents
    3. the doc string's raw element


  Background: Test file setup.
    Given the following feature file:
    """
    Feature:

      Scenario:
        * some wordy step:
        \"\"\" content type
      some text
            some more text
        \"\"\"
        * some wordy step:
        \"\"\"
        \"\"\"
    """
    When the file is read


  Scenario: The raw doc string element is modeled.
    Then the doc string correctly stores its underlying implementation

  Scenario: The doc string's content type is modeled.
    Then the step "1" doc string content type is "content type"
    And the step "2" doc string has no content type

  Scenario: The doc string's contents are modeled.
    Then the step "1" doc string has the following contents:
      | 'some text'          |
      | '    some more text' |
    And the step "2" doc string contents are empty

  Scenario Outline: Doc String models pass all other specifications
  Exact specifications detailing the API for Doc String models.
    Given that there are "<additional specifications>" detailing models
    When the corresponding specifications are run
    Then all of those specifications are met
  Examples:
    | additional specifications      |
    | doc_string_unit_spec.rb        |
    | doc_string_integration_spec.rb |
