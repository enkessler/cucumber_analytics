Feature: Outputting feature file elements


  Scenario: Output of a feature file
    Given a feature file element based on "some_feature_file.feature"
    When it is outputted
    Then the following text is provided:
    """
    path_to/some_feature_file.feature
    """
