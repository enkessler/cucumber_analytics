Feature: The gem can analyze .feature files that have Scenario elements.

  Background: Test file setup.
    Given the following feature file:
    """
    @a_feature_level_tag
    Feature: The test feature name.
      Some more feature description.

      @a_tag

      @another_tag@yet_another_tag
      Scenario: The first scenario's name.
    #a comment

        Some text describing the scenario.
        More text.
        Given the first step

        When the second step
          #here too
        Then the third step

    """
    When the file is parsed

  Scenario: The parser can extract various information about the feature.
    Then the feature is found to have the following properties:
      | scenario_count | 1 |

  Scenario: The parser can extract a scenario's name.
    Then scenario "1" is found to have the following properties:
      | name | The first scenario's name. |

  Scenario: The parser can extract a scenario description.
    Then scenario "1" descriptive lines are as follows:
      | Some text describing the scenario. |
      | More text.                         |

  Scenario: The parser can extract a scenario's steps.
    Then scenario "1" steps "with" keywords are as follows:
      | Given the first step |
      | When the second step |
      | Then the third step  |
    And scenario "1" steps "without" keywords are as follows:
      | the first step  |
      | the second step |
      | the third step  |

  Scenario: The parser can extract a scenario's tags
    Then scenario "1" is found to have the following tags:
      | @a_tag           |
      | @another_tag     |
      | @yet_another_tag |
