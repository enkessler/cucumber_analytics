module CucumberAnalytics

  # A class modeling a Cucumber feature's Background.

  class Background < TestElement

    # Creates a new Background object and, if *source* is provided, populates
    # the object.
    def initialize(source = nil)
      parsed_background = process_source(source)

      super(parsed_background)

      build_background(parsed_background) if parsed_background
    end


    private


    def build_background(parsed_background)
      # Just a stub in case something specific needs to be done
    end

  end
end
