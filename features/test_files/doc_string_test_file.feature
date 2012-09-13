@test_feature
Feature: A feature file containing elements that use doc strings.

  Background: Some general test setup stuff.
    * some big setup step:
    """
  some text

    #some comments
    Scenario:
    Scenario Outline:
    Examples:
    @
    Feature:
    |
    Given
    When
    Then
    *
        some more text
    """
    * some setup step

  Scenario: The first scenario's name.
    Given the first step
    When a big step:
    """
  some text

    #some comments
    Scenario:
    Scenario Outline:
    Examples:
    @
    Feature:
    |
    Given
    When
    Then
    *
        some more text
    """
    Then the third step

  Scenario Outline: The scenario outline's name.
    Given the first "<param1>"
    When a big step:
    """
  some text

    #some comments
    Scenario:
    Scenario Outline:
    Examples:
    @
    Feature:
    |
    Given
    When
    Then
    *
        some more text
    """
    When the second "<param2>"
    Then the third step
  Examples:
    | param1 | param2 |
    | x      | y      |
