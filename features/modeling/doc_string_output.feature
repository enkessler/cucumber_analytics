Feature: Outputting doc string elements

  The output of an element model is a representation of the element as it would
  appear in gherkin.


  Scenario: Output of a doc string without a content type
    Given a doc string element based on the following gherkin:
    """
    \"\"\"
    Some text

      some more text
    \"\"\"
    """
    When it is outputted
    Then the following text is provided:
    """
    \"\"\"
    Some text

      some more text
    \"\"\"
    """

  Scenario: Output of a doc string with a content type
    Given a doc string element based on the following gherkin:
    """
    \"\"\" the type
    Some text

      some more text
    \"\"\"
    """
    When it is outputted
    Then the following text is provided:
    """
    \"\"\" the type
    Some text

      some more text
    \"\"\"
    """
