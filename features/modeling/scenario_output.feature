Feature: Outputting scenario elements


  Scenario: Output of a scenario that does not have a name
    Given a scenario element based on the following gherkin:
    """
    Scenario:
    """
    When it is outputted
    Then the following text is provided:
    """
    Scenario:
    """

  Scenario: Output of a scenario that does have a name
    Given a scenario element based on the following gherkin:
    """
    Scenario: with a name
    """
    When it is outputted
    Then the following text is provided:
    """
    Scenario: with a name
    """

  Scenario: Output of a scenario that has tags
    Given a scenario element based on the following gherkin:
    """
    @tag1@tag2
    @tag3
    Scenario:
    """
    When it is outputted
    Then the following text is provided:
    """
    @tag1 @tag2 @tag3
    Scenario:
    """

  Scenario: Output of a scenario that has a description
    Given a scenario element based on the following gherkin:
    """
    Scenario:
    Some description.
    Some more description.
    """
    When it is outputted
    Then the following text is provided:
    """
    Scenario:

        Some description.
        Some more description.
    """

  Scenario: Output of a scenario that has steps
    Given a scenario element based on the following gherkin:
    """
    Scenario:
    * a step
    * another step
    """
    When it is outputted
    Then the following text is provided:
    """
    Scenario:
      * a step
      * another step
    """

  Scenario: Output of a scenario that contains all possible parts
    Given a scenario element based on the following gherkin:
    """
    @tag1@tag2
    @tag3
    Scenario: A scenario with everything it could have
    Including a description
    and then some.

    * a step
    * another step
    """
    When it is outputted
    Then the following text is provided:
    """
    @tag1 @tag2 @tag3
    Scenario: A scenario with everything it could have

        Including a description
        and then some.

      * a step
      * another step
    """
