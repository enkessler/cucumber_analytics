Feature: Outputting background elements


  Scenario: Output of a background that does not have a name
    Given a background element based on the following gherkin:
    """
    Background:
    """
    When it is outputted
    Then the following text is provided:
    """
    Background:
    """

  Scenario: Output of a background that does have a name
    Given a background element based on the following gherkin:
    """
    Background: with a name
    """
    When it is outputted
    Then the following text is provided:
    """
    Background: with a name
    """

  Scenario: Output of a background that has a description
    Given a background element based on the following gherkin:
    """
    Background:
    Some description.
    Some more description.
    """
    When it is outputted
    Then the following text is provided:
    """
    Background:

        Some description.
        Some more description.
    """

  Scenario: Output of a background that has steps
    Given a background element based on the following gherkin:
    """
    Background:
    * a step
    * another step
    """
    When it is outputted
    Then the following text is provided:
    """
    Background:
      * a step
      * another step
    """

  Scenario: Output of a background that contains all possible parts
    Given a background element based on the following gherkin:
    """
    Background: A background with everything it could have
    Including a description
    and then some.

    * a step
    * another step
    """
    When it is outputted
    Then the following text is provided:
    """
    Background: A background with everything it could have

        Including a description
        and then some.

      * a step
      * another step
    """
