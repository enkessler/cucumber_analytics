Feature: Outputting row elements


  Scenario: Output of a row that does not have cells

  Although it is not a case encountered in gherkin, it is possible for a row
  model to be in such a state.

    Given a row element
    And the row element has no cells
    When it is outputted
    Then the following text is provided:
    """
    """

  Scenario: Output of a row that has one cell
    Given a row element based on the following gherkin:
    """
    |value|
    """
    When it is outputted
    Then the following text is provided:
    """
    | value |
    """

  Scenario: Output of a row that has multiple cells
    Given a row element based on the following gherkin:
    """
    |value|another_value|
    """
    When it is outputted
    Then the following text is provided:
    """
    | value | another_value |
    """
