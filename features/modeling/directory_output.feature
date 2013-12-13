Feature: Outputting directory elements


  Scenario: Output of a directory
    Given a directory element based on "some_directory"
    When it is outputted
    Then the following text is provided:
    """
    path_to/some_directory
    """
