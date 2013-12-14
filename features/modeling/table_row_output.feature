Feature: Outputting table row elements


  Scenario: Output of a table row that does not have cells

  Although it is not a case encountered in gherkin, it is possible for a table
  row model to be in such a state.

    Given a table row element
    And the table row element has no cells
    When it is outputted
    Then the following text is provided:
    """
    """

  Scenario: Output of a table row that has one cell
    Given a table row element based on the following gherkin:
    """
    |value|
    """
    When it is outputted
    Then the following text is provided:
    """
    | value |
    """

  Scenario: Output of a table row that has multiple cells
    Given a table row element based on the following gherkin:
    """
    |value|another_value|
    """
    When it is outputted
    Then the following text is provided:
    """
    | value | another_value |
    """
