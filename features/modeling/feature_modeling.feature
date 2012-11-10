Feature: Features can be modeled.


  Acceptance criteria

  All conceptual pieces of a Feature can be modeled:
    1. the feature's name
    2. the feature's description
    3. the feature's tags
    4. the feature's scenarios
    5. the feature's outlines
    6. the feature's background
    7. the feature's total number of tests
    8. the feature's total number of test cases


  Background: Test file setup.
    Given the following feature file "much_stuff.feature":
    """
    #Don't mind me.
    #Or any line that is a comment, really.
    @a_feature_level_tag @and_another@and_another

    Feature: The test feature name.
      Some more feature description.

      And some more.

      Scenario but not really because I left out the magic ':'
        Given some description that uses keywords
        And more of it
        When I chuck the kitchen sink at it:
        But
        *
        |

        Scenario Outline
        Examples
        \"\"\"
        Background
        Then this is still one big valid description
        # Oddly enough, if this comment had come earlier in the description
        # it would have broken Cucumber. Comments can't be mixed into the
        # freeform text for some reason.


      Background: Some general test setup stuff.
        A little more information.
        * some setup step

      @a_tag

      @another_tag@yet_another_tag
      Scenario: The first scenario's name.
        Some text describing the scenario.
        More text.
        Given the first step
        And this step takes a table:
          | data      |
          | more data |
        When the second step
        Then the third step
    #Random comment
      @outline_tag
      Scenario Outline: The scenario outline's name.
        Some text describing the scenario.
        More text.
        Given the first "<param1>"
        And this step takes a table:
          | data      |
          | more data |
        When the second "<param2>"
        Then the third step
      Examples: text describing the significance of the examples
        | param1 | param2 |
        | x      | y      |

        @example_tag

      Examples: some examples with different significance and a tag
        | param1 | param2 |
        | a      | b      |
        | c      | d      |


      Scenario: The second scenario's name.
        Some text describing the scenario.
        More text.
        Given the first step
        When the second step
        Then the third step

    """
    And the following feature file "barely_any_stuff.feature":
    """
    Feature:

      Background:

      Scenario:

      Scenario Outline:
      Examples:
    """
    And the following feature file "as_empty_as_it_gets.feature":
    """
    Feature:
    """
    When the file "much_stuff.feature" is read
    And the file "barely_any_stuff.feature" is read
    And the file "as_empty_as_it_gets.feature" is read


  Scenario: The feature's properties are modeled.
    Then feature "1" is found to have the following properties:
      | name            | The test feature name. |
      | test_count      | 3                      |
      | test_case_count | 5                      |
    And feature "2" is found to have the following properties:
      | name            |   |
      | test_count      | 2 |
      | test_case_count | 1 |

    And feature "3" is found to have the following properties:
      | name            |   |
      | test_count      | 0 |
      | test_case_count | 0 |

  Scenario: The feature's description is modeled.
    Then the descriptive lines of feature "1" are as follows:
      | Some more feature description.                                      |
      | And some more.                                                      |
      | Scenario but not really because I left out the magic ':'            |
      | Given some description that uses keywords                           |
      | And more of it                                                      |
      | When I chuck the kitchen sink at it:                                |
      | But                                                                 |
      | *                                                                   |
      | \|                                                                  |
      | Scenario Outline                                                    |
      | Examples                                                            |
      | """                                                                 |
      | Background                                                          |
      | Then this is still one big valid description                        |
    And feature "2" has no descriptive lines
    And feature "3" has no descriptive lines

  Scenario: The feature's tags are modeled.
    Then feature "1" is found to have the following tags:
      | @a_feature_level_tag |
      | @and_another         |
      | @and_another         |
    And feature "2" has no tags
    And feature "3" has no tags

  Scenario: The feature's scenarios are modeled.
    Then feature "1" is found to have the following properties:
      | scenario_count | 2 |
    And feature "1" scenarios are as follows:
      | The first scenario's name.  |
      | The second scenario's name. |
    And feature "2" is found to have the following properties:
      | scenario_count | 1 |
    And feature "2" scenarios are as follows:
      |  |
    And feature "3" is found to have the following properties:
      | scenario_count | 0 |
    And feature "3" has no scenarios

  Scenario: The feature's outlines are modeled.
    Then feature "1" is found to have the following properties:
      | outline_count | 1 |
    And feature "1" outlines are as follows:
      | The scenario outline's name. |
    And feature "2" is found to have the following properties:
      | outline_count | 1 |
    And feature "2" outlines are as follows:
      |  |
    And feature "3" is found to have the following properties:
      | outline_count | 0 |
    And feature "3" has no outlines

  Scenario: The feature's background is modeled.
    Then feature "1" is found to have the following properties:
      | has_background? | true |
    And feature "1" background is as follows:
      | Some general test setup stuff. |
    And feature "2" is found to have the following properties:
      | has_background? | true |
    And feature "2" background is as follows:
      |  |
    And feature "3" is found to have the following properties:
      | has_background? | false |
    And feature "3" has no background
