module CucumberAnalytics

  # A class modeling a Cucumber feature's Background.

  class Background < TestElement

    # Creates a new Background object and, if *source* is provided, populates
    # the object.
    def initialize(source = nil)
      parsed_background = process_source(source)

      super(parsed_background)
    end

  end
end
