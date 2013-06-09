module CucumberAnalytics

  # A class modeling a Cucumber feature's Background.

  class Background < TestElement

    # Creates a new Background object and, if *source* is provided, populates
    # the object.
    def initialize(source = nil)
      CucumberAnalytics::Logging.logger.info('Background#initialize')
      CucumberAnalytics::Logging.logger.debug('source:')
      CucumberAnalytics::Logging.logger.debug(source)

      parsed_background = process_source(source)

      super(parsed_background)
    end

  end
end
