Feature: Entire directories can be read and modeled.


  Background: Setup test directories
    Given a directory "feature_directory"
    And the following feature file "test_file_1.feature":
    """
    Feature: The test feature 1.

      Scenario: The first scenario's name.
        Given the first step
        When the second step
        Then the third step
    """
    And the following feature file "test_file_2.feature":
    """
    Feature: The test feature 2.

      Scenario: The first scenario's name.
        Given the first step
        When the second step
        Then the third step
    """
    And the following feature file "test_file_3.feature":
    """
    Feature: The test feature 3.

      Scenario: The first scenario's name.
        Given the first step
        When the second step
        Then the third step
    """
    And the following file "random.file":
    """
    Not a .feature file.
    """

    Given a directory "feature_directory/nested_directory"
    And the following feature file "test_file_4.feature":
    """
    Feature: The test feature 1.

      Scenario: The first scenario's name.
        Given the first step
        When the second step
        Then the third step
    """
    And the following feature file "test_file_5.feature":
    """
    Feature: The test feature 2.

      Scenario: The first scenario's name.
        Given the first step
        When the second step
        Then the third step
    """
    And the following feature file "test_file_6.feature":
    """
    Feature: The test feature 3.

      Scenario: The first scenario's name.
        Given the first step
        When the second step
        Then the third step
    """
    And the following file "another_random.file":
    """
    Not a .feature file.
    """

    When the directory "feature_directory" is read

  Scenario: The parser can extract various information about the directory.
    Then the directory is found to have the following properties:
      | feature_count | 6          |
