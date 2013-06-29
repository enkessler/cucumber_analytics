module CucumberAnalytics

  # A mix-in module containing methods used by elements that can be tagged.

  module Taggable

    # The tags which are directly assigned to the element
    attr_accessor :tags


    # Returns the tags which are indirectly assigned to the element (i.e. they
    # have been inherited from a parent element).
    def applied_tags
      CucumberAnalytics::Logging.log_method("Taggable##{__method__}")

      @parent_element.respond_to?(:all_tags) ? @parent_element.all_tags : []
    end

    # Returns all of the tags which are applicable to the element.
    def all_tags
      CucumberAnalytics::Logging.log_method("Taggable##{__method__}")

      applied_tags + @tags
    end


    private


    def populate_element_tags(parsed_element)
      CucumberAnalytics::Logging.log_method("Taggable##{__method__}", method(__method__).parameters.map { |arg| "#{arg[1].to_s} = #{eval arg[1].to_s}" })

      if parsed_element['tags']
        parsed_element['tags'].each do |tag|
          @tags << tag['name']
        end
      end
    end

  end
end
