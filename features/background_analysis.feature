Feature: The gem can analyze .feature files that have Background elements.

  Background: Test file setup.
    Given the following feature file:
    """
    Feature: The test feature name.
      Some more feature description.

      Background: Some general test setup stuff.
      #unimportant text
      #   more of the same
        A little more information.


        * some setup step

        * some setup step
#
        * some setup step

      Scenario: The first scenario's name.
        Given the first step
        When the second step
        Then the third step
    """
    When the file is parsed


  Scenario: The parser can extract various information about the feature.
    Then the feature is found to have the following properties:
      | has_background? | true |

  Scenario: The parser can extract the background name.
    Then the background is found to have the following properties:
      | name | Some general test setup stuff. |

  Scenario: The parser can extract the background description.
    Then the background's descriptive lines are as follows:
      | A little more information. |

  Scenario: The parser can extract the background steps.
    Then the background's steps "with" keywords are as follows:
      | * some setup step |
      | * some setup step |
      | * some setup step |
    And the background's steps "without" keywords are as follows:
      | some setup step |
      | some setup step |
      | some setup step |
