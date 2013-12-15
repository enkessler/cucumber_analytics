Feature: Outputting example elements


  Scenario: Output of an example that does not have parameters or rows

  Although it is not a case encountered in gherkin, it is possible for an example
  model to be in such a state.

    Given an example element
    And the example element has no parameters or rows
    When it is outputted
    Then the following text is provided:
    """
    Examples:
    """

  Scenario: Output of an example that does not have a name
    Given an example element based on the following gherkin:
    """
    Examples:
    |param|
    """
    When it is outputted
    Then the following text is provided:
    """
    Examples:
      | param |
    """

  Scenario: Output of an example that does have a name
    Given an example element based on the following gherkin:
    """
    Examples: with a name
    |param|
    """
    When it is outputted
    Then the following text is provided:
    """
    Examples: with a name
      | param |
    """

  Scenario: Output of an example that does not have tags
    Given an example element based on the following gherkin:
    """
    Examples:
    |param|
    """
    When it is outputted
    Then the following text is provided:
    """
    Examples:
      | param |
    """

  Scenario: Output of an example that does have tags
    Given an example element based on the following gherkin:
    """
    @tag1@tag2
    @tag3
    Examples:
    |param|
    """
    When it is outputted
    Then the following text is provided:
    """
    @tag1 @tag2 @tag3
    Examples:
      | param |
    """

  Scenario: Output of an example that has a description
    Given an example element based on the following gherkin:
    """
    Examples:
    Some description.
    Some more description.
    |param|
    """
    When it is outputted
    Then the following text is provided:
    """
    Examples:

        Some description.
        Some more description.

      | param |
    """

  Scenario: Output of an example that has one rows
    Given an example element based on the following gherkin:
    """
    Examples:
    |param1|param2|
    |value1|value2|
    """
    When it is outputted
    Then the following text is provided:
    """
    Examples:
      | param1 | param2 |
      | value1 | value2 |
    """

  Scenario: Output of an example that has multiple rows
    Given an example element based on the following gherkin:
    """
    Examples:
    |param1|param2|
    |value1|value2|
    |value3|value4|
    """
    When it is outputted
    Then the following text is provided:
    """
    Examples:
      | param1 | param2 |
      | value1 | value2 |
      | value3 | value4 |
    """

  Scenario: Output of an example that contains all possible parts
    Given an example element based on the following gherkin:
    """
    @tag1@tag2
    @tag3
    Examples: with a name
    Some description.
    Some more description.
    |param1|param2|
    |value1|value2|
    |value3|value4|
    """
    When it is outputted
    Then the following text is provided:
    """
    @tag1 @tag2 @tag3
    Examples: with a name

        Some description.
        Some more description.

      | param1 | param2 |
      | value1 | value2 |
      | value3 | value4 |
    """

  Scenario: Whitespace buffers are based on the longest value or parameter in a column
    Given an example element based on the following gherkin:
    """
    Examples:
    |parameter_name|x|
    |y|value_name|
    """
    When it is outputted
    Then the following text is provided:
    """
    Examples:
      | parameter_name | x          |
      | y              | value_name |
    """
