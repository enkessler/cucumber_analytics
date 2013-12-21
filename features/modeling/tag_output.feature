Feature: Outputting tag elements


  Scenario: Output of a tag that has a name
    Given a tag element based on the following gherkin:
    """
    @some_tag
    """
    When it is outputted
    Then the following text is provided:
    """
    @some_tag
    """
