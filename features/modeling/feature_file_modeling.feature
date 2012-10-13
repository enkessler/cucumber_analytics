Feature: Feature files can be modeled.


  Acceptance criteria

  All conceptual pieces of a .feature file can be modeled:
    1. the files's name
    2. the file's full path
    3. the file's features (only one per file)


  Background: Test file setup.
    Given the following feature file "test_file_1.feature":
    """
    Feature: The first test feature
      Just a dummy feature.
    """
    And the following feature file "test_file_2.feature":
    """
    Feature: The second test feature
      Just a dummy feature.
    """
    When the file "test_file_1.feature" is read
    And the file "test_file_2.feature" is read


  Scenario: The file's feature is modeled.
    Then file "1" is found to have the following properties:
      | name          | test_file_1.feature         |
      | path          | path_to/test_file_1.feature |
    And file "1" features are as follows:
      | The first test feature |
    Then file "2" is found to have the following properties:
      | name          | test_file_2.feature         |
      | path          | path_to/test_file_2.feature |
    And file "2" features are as follows:
      | The second test feature |
