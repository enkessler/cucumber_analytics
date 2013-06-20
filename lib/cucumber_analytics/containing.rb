module CucumberAnalytics


  module Containing


    private


    def build_child_element(clazz, element_data)
      CucumberAnalytics::Logging.log_method("#{self.class}##{__method__}", method(__method__).parameters.map { |arg| "#{arg[1].to_s} = #{eval arg[1].to_s}" })

      element = clazz.new(element_data)
      element.parent_element = self

      element
    end

  end
end
