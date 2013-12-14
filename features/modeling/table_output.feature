Feature: Outputting table elements


  Scenario: Output of a table that does not have rows

  Although it is not a case encountered in gherkin, it is possible for a table
  model to be in such a state.

    Given a table element
    And the table element has no rows
    When it is outputted
    Then the following text is provided:
    """
    """

  Scenario: Output of a table that has one row
    Given a table element based on the following gherkin:
    """
    |value|
    """
    When it is outputted
    Then the following text is provided:
    """
    | value |
    """

  Scenario: Output of a table that has multiple rows
    Given a table element based on the following gherkin:
    """
    |value1|
    |value2|
    """
    When it is outputted
    Then the following text is provided:
    """
    | value1 |
    | value2 |
    """

  Scenario: Whitespace buffers are based on the longest value in a column
    Given a table element based on the following gherkin:
    """
    |value|x|
    |y|another_value|
    """
    When it is outputted
    Then the following text is provided:
    """
    | value | x             |
    | y     | another_value |
    """
