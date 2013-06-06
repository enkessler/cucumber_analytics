module CucumberAnalytics
  module Taggable

    # The tags directly assigned to the element
    attr_accessor :tags

    # Returns tags which are applicable to the element which have been
    # inherited from a parent element.
    def applied_tags
      CucumberAnalytics::Logging.logger.info('Taggable#applied_tags')

      @parent_element.respond_to?(:all_tags) ? @parent_element.all_tags : []
    end

    # Returns all tags which are applicable to the element.
    def all_tags
      CucumberAnalytics::Logging.logger.info('Taggable#all_tags')

      applied_tags + @tags
    end


    private


    def parse_element_tags(parsed_element)
      CucumberAnalytics::Logging.logger.info('Taggable#parse_element_tags')
      CucumberAnalytics::Logging.logger.debug('parsed_element:')
      CucumberAnalytics::Logging.logger.debug(parsed_element.to_yaml)

      if parsed_element['tags']
        parsed_element['tags'].each do |tag|
          @tags << tag['name']
        end
      end
    end

  end
end
