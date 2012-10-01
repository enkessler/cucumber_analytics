Feature: Defined and undefined steps can be detected.

  Background: Setup test directories
    Given a directory "feature_directory"
    And the following feature file "test_file_1.feature":
    """
    Feature: The test feature 1.

      Background: Some general test setup stuff.
        Given a defined step
        And an undefined step
    """
    And the following feature file "test_file_2.feature":
    """
    Feature: The test feature 2.

      Scenario: The scenario's name.
        Given another defined step
        Then another undefined step
    """
    And the following feature file "test_file_3.feature":
    """
    Feature: The test feature 3.

      Scenario Outline: The scenario outline's name.
        Given a defined step
        When another defined step
        Then *<this>* *step is* *<undefined>*
      Examples:
        | this | undefined |
        | x    | y         |
      Examples:
        | this | undefined |
        | a    | b         |
    """
    And the following step definition file:
    """
    Given /^a defined step$/ do
      pending
    end

    Given /^another defined step$/ do
      pending
    end
    """
    When the directory is read
    And the step definitions are loaded


  Scenario: Undefined steps can be identified.
    Then there are "3" undefined steps
    And the undefined steps "with" keywords are:
      | And an undefined step                 |
      | Then *<this>* *step is* *<undefined>* |
      | Then another undefined step           |
    And the undefined steps "without" keywords are:
      | an undefined step                |
      | *<this>* *step is* *<undefined>* |
      | another undefined step           |

  Scenario: Defined steps can be identified.
    Then there are "4" defined steps
    And the defined steps "with" keywords are:
      | Given a defined step       |
      | Given another defined step |
      | When another defined step  |
      | Given a defined step       |
    And the defined steps "without" keywords are:
      | a defined step       |
      | another defined step |
      | another defined step |
      | a defined step       |
