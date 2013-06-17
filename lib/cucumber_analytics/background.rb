module CucumberAnalytics

  # A class modeling a Cucumber feature's Background.

  class Background < TestElement

    # Creates a new Background object and, if *source* is provided, populates
    # the object.
    def initialize(source = nil)
      CucumberAnalytics::Logging.log_method("Background##{__method__}", method(__method__).parameters.map { |arg| "#{arg[1].to_s} = #{eval arg[1].to_s}" })

      parsed_background = process_source(source)

      super(parsed_background)
    end

  end
end
