Feature: Table elements can be modeled.


  Acceptance criteria

  All conceptual pieces of a Table can be modeled:
    1. the table's contents
    2. the table's raw element


  Background: Test file setup.
    Given the following feature file:
    """
    Feature:

      Scenario:
        * some data filled step:
          | value 1 | value 2 |
          | value 3 | value 4 |
        * some data filled step:
          | value 1 |
          | value 2 |
    """
    When the file is read


  Scenario: The table's contents are modeled.
    Then the step "1" table has the following contents:
      | value 1 | value 2 |
      | value 3 | value 4 |
    And the step "2" table has the following contents:
      | value 1 |
      | value 2 |

  Scenario: The raw table element is modeled.
    Then the table correctly stores its underlying implementation

  Scenario Outline: Table models pass all other specifications
  Exact specifications detailing the API for Table String models.
    Given that there are "<additional specifications>" detailing models
    When the corresponding specifications are run
    Then all of those specifications are met
  Examples:
    | additional specifications |
    | table_unit_spec.rb        |
    | table_integration_spec.rb |
