Feature: Steps can be collected from arbitrary parts of the codebase.


  Acceptance criteria

  Steps (both defined and undefined) can be collected from:
    1. backgrounds
    2. scenarios
    3. outlines
    4. features
    5. files
    6. directories


  Background: Setup test directories
    Given a directory "feature_directory"
    And the following feature file "test_file_1.feature":
    """
    Feature: The test feature 1.

      Background: Some general test setup stuff.
        Given a defined step
        And an undefined step

      Scenario: The scenario's name.
        Given another defined step
        Then another undefined step
    """
    And the file "test_file_1.feature" is read
    And a directory "feature_directory/nested_directory"
    And the following feature file "test_file_2.feature":
    """
    Feature: The test feature 2.

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
    And the file "test_file_2.feature" is read
    And the following step definition file:
    """
    Given /^a defined step$/ do
      pending
    end

    Given /^another defined step$/ do
      pending
    end
    """
    When the directory "feature_directory" is read
    And the step definitions are loaded


  Scenario: Steps can be collected from backgrounds
    Then the steps collected from feature "1" background are as follows:
      | Given a defined step  |
      | And an undefined step |
    And the "defined" steps collected from feature "1" background are as follows:
      | Given a defined step |
    And the "undefined" steps collected from feature "1" background are as follows:
      | And an undefined step |

  Scenario: Steps can be collected from scenarios
    Then the steps collected from feature "1" scenario "1" are as follows:
      | Given another defined step  |
      | Then another undefined step |
    And the "defined" steps collected from feature "1" scenario "1" are as follows:
      | Given another defined step |
    And the "undefined" steps collected from feature "1" scenario "1" are as follows:
      | Then another undefined step |

  Scenario: Steps can be collected from scenario outlines
    Then the steps collected from feature "2" scenario "1" are as follows:
      | Given a defined step                  |
      | When another defined step             |
      | Then *<this>* *step is* *<undefined>* |
    And the "defined" steps collected from feature "2" scenario "1" are as follows:
      | Given a defined step      |
      | When another defined step |
    And the "undefined" steps collected from feature "2" scenario "1" are as follows:
      | Then *<this>* *step is* *<undefined>* |

  Scenario: Steps can be collected from features
    Then the steps collected from feature "1" are as follows:
      | Given a defined step        |
      | And an undefined step       |
      | Given another defined step  |
      | Then another undefined step |
    And the "defined" steps collected from feature "1" are as follows:
      | Given a defined step       |
      | Given another defined step |
    And the "undefined" steps collected from feature "1" are as follows:
      | And an undefined step       |
      | Then another undefined step |

  Scenario: Steps can be collected from files
    Then the steps collected from file "1" are as follows:
      | Given a defined step        |
      | And an undefined step       |
      | Given another defined step  |
      | Then another undefined step |
    And the "defined" steps collected from file "1" are as follows:
      | Given a defined step       |
      | Given another defined step |
    And the "undefined" steps collected from file "1" are as follows:
      | And an undefined step       |
      | Then another undefined step |

  Scenario: Steps can be collected from directories
    Then the steps collected from the directory are as follows:
      | Given a defined step                  |
      | And an undefined step                 |
      | Given another defined step            |
      | Then another undefined step           |
      | Given a defined step                  |
      | When another defined step             |
      | Then *<this>* *step is* *<undefined>* |
    And the "defined" steps collected from the directory are as follows:
      | Given a defined step       |
      | Given another defined step |
      | Given a defined step       |
      | When another defined step  |
    And the "undefined" steps collected from the directory are as follows:
      | And an undefined step                 |
      | Then another undefined step           |
      | Then *<this>* *step is* *<undefined>* |
