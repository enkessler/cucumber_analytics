Feature: Scenario Outline elements can be modeled.


  Acceptance criteria

  All conceptual pieces of a Scenario Outline can be modeled:
    1. the outline's name
    2. the outline's description
    3. the outline's steps
    4. the outline's tags
    5. the outline's applied tags
    6. the outline's example blocks
    7. the outline's source line


  Background: Test file setup.
    Given the following feature file:
    """
    @a_feature_level_tag
    Feature:

      @outline_tag
      Scenario Outline: The scenario outline's name.
          Some outline description
          Some more description

        Given a <setup> step
        When an action step
        Then a <verification> step

      Examples: example 1
        | setup | verification |
        | x     | y            |
      Examples: example 2
        | setup | verification |
        | a     | b            |
    """
    And parameter delimiters of "*" and "*"
    When the file is read

  Scenario: The outline source line is modeled.
    Then the test is found to have the following properties:
      | source_line | 5 |

  Scenario: The outline name is modeled.
    Then the test is found to have the following properties:
      | name | The scenario outline's name. |

  Scenario: The outline description is modeled.
    Then the test descriptive lines are as follows:
      | Some outline description |
      | Some more description    |

  Scenario: The outline steps are modeled.
    Then the test steps are as follows:
      | a <setup> step        |
      | an action step        |
      | a <verification> step |

  Scenario: The outline tags are modeled.
    Then the test is found to have the following tags:
      | @outline_tag |

  Scenario: The outline applied tags are modeled.
    Then the test is found to have the following applied tags:
      | @a_feature_level_tag |

  Scenario: The outline example blocks are modeled.
    And the test example blocks are as follows:
      | example 1 |
      | example 2 |

  Scenario Outline: Outline models pass all other specifications
  Exact specifications detailing the API for Scenario Outline models.
    Given that there are "<additional specifications>" detailing models
    When the corresponding unit tests are run
    Then all of those specifications are met
  Examples:
    | additional specifications   |
    | outline_unit_spec.rb        |
    | outline_integration_spec.rb |
