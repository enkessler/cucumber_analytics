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

    # Returns gherkin representation of the background.
    def to_s
      text = ''

      name_text = 'Background:'
      name_text += " #{name}" unless name == ''
      text << name_text

      unless description.empty?
        description_text = "\n"
        description_text += description.collect { |line| "\n    #{line}" }.join
        text << description_text
        text << "\n" unless steps.empty?
      end

      unless steps.empty?
        step_text = steps.collect { |step| step.to_s.split("\n").collect { |line| line.empty? ? "\n" : "\n  #{line}" }.join }.join
        text << step_text
      end

      text
    end


    private


    def build_background(parsed_background)
      # Just a stub in case something specific needs to be done
    end

  end
end
