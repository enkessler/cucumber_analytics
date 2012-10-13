Feature: Directories can be modeled.


  Acceptance criteria

  Directories containing feature files can be modeled:
    1. all feature files contained


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
    And the following file "another_random.file":
    """
    Not a .feature file.
    """
    When the directory "feature_directory" is read
    And the directory "feature_directory/nested_directory" is read

  Scenario: The directory's feature files are modeled.
    Then directory "1" is found to have the following properties:
      | feature_file_count | 3 |
    And directory "1" feature files are as follows:
      | test_file_1.feature |
      | test_file_2.feature |
      | test_file_3.feature |
    Then directory "2" is found to have the following properties:
      | feature_file_count | 2 |
    And directory "2" feature files are as follows:
      | test_file_4.feature |
      | test_file_5.feature |
