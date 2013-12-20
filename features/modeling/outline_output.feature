Feature: Outputting outline elements


  Scenario: Output of an outline that does not have a name
    Given an outline element based on the following gherkin:
    """
    Scenario Outline:
    """
    When it is outputted
    Then the following text is provided:
    """
    Scenario Outline:
    """

  Scenario: Output of an outline that does have a name
    Given an outline element based on the following gherkin:
    """
    Scenario Outline: with a name
    """
    When it is outputted
    Then the following text is provided:
    """
    Scenario Outline: with a name
    """

  Scenario: Output of an outline that does have tags
    Given an outline element based on the following gherkin:
    """
    @tag1@tag2
    @tag3
    Scenario Outline:
    """
    When it is outputted
    Then the following text is provided:
    """
    @tag1 @tag2 @tag3
    Scenario Outline:
    """

  Scenario: Output of an outline that has a description
    Given an outline element based on the following gherkin:
    """
    Scenario Outline:
    Some description.
    Some more description.
    """
    When it is outputted
    Then the following text is provided:
    """
    Scenario Outline:

        Some description.
        Some more description.
    """

  Scenario: Output of an outline that has steps
    Given an outline element based on the following gherkin:
    """
    Scenario Outline:
    * a step
    * another step
    """
    When it is outputted
    Then the following text is provided:
    """
    Scenario Outline:
      * a step
      * another step
    """

  Scenario: Output of an outline that has examples
    Given an outline element based on the following gherkin:
    """
    Scenario Outline:
    * a <value> step
    Examples:
    | value |
    | x     |
    Examples:
    | value |
    | y     |
    """
    When it is outputted
    Then the following text is provided:
    """
    Scenario Outline:
      * a <value> step

    Examples:
      | value |
      | x     |

    Examples:
      | value |
      | y     |
    """

  Scenario: Output of an outline that contains all possible parts
    Given an outline element based on the following gherkin:
    """
    @tag1@tag2
    @tag3
    Scenario Outline: An outline with everything it could have
    Some description.
    Some more description.
    * a step
    * a <value> step
    Examples:
    Some description.
    Some more description.
    | value |
    | x     |
    Examples:
    | value |
    | y     |
    """
    When it is outputted
    Then the following text is provided:
    """
    @tag1 @tag2 @tag3
    Scenario Outline: An outline with everything it could have

        Some description.
        Some more description.

      * a step
      * a <value> step

    Examples:

        Some description.
        Some more description.

      | value |
      | x     |

    Examples:
      | value |
      | y     |
    """
