Feature: The gem can analyze .feature files that have Scenario Outline elements.

  Background: Test file setup.
    Given the following feature file:
    """
    @a_feature_level_tag
    Feature: The test feature name.
      Some more feature description.

      @outline_tag
      Scenario Outline: The scenario outline's name.
        Some text describing the scenario.
        More text.
        Given the first "<param1>"
        When the second "<param2>"
        Then the third step
      Examples: text describing the significance of the examples
        | param1 | param2 |
        #A more random comment
        | x      | y      |
        @example_tag
      Examples: some examples with different significance and a tag
        | param1 | param2 |
        | a      | b      |
    """
    When the file is parsed

  Scenario: The parser can extract various information about the feature.
    Then the feature is found to have the following properties:
      | outline_count | 1 |

  Scenario: The parser can extract a scenario outline's name.
    Then scenario "1" is found to have the following properties:
      | name | The scenario outline's name. |

  Scenario: The parser can extract a scenario outline description.
    Then scenario "1" descriptive lines are as follows:
      | Some text describing the scenario. |
      | More text.                         |

  Scenario: The parser can extract a scenario outline's steps.
    Then scenario "1" steps are as follows:
      | Given the first "<param1>" |
      | When the second "<param2>" |
      | Then the third step        |

  Scenario: The parser can extract a scenario outline's tags
    Then scenario "1" is found to have the following tags:
      | @outline_tag |

  Scenario Outline: The parser can extract a scenario outline's examples.
    Then "<outline>" example "<set>" has a "<description>"
    And "<outline>" example "<set>" has "<tags>"
    And "<outline>" example "<set>" rows are as follows:
      | <row1> |
      | <row2> |
  Examples:
    | outline | set | description                                      | tags         | row1                   | row2                   |
    | 1       | 1   | text describing the significance of the examples |              | \| param1 \| param2 \| | \| x      \| y      \| |
    | 1       | 2   | some examples with different significance        | @example_tag | \| param1 \| param2 \| | \| a      \| b      \| |
