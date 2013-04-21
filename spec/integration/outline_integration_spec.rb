require 'spec_helper'

SimpleCov.command_name('ParsedOutline') unless RUBY_VERSION.to_s < '1.9.0'

describe 'ParsedOutline' do

  it 'properly sets its child elements' do
    source = ['  Scenario Outline:',
              '    * a step',
              '  Examples:',
              '    | param |']
    source = source.join("\n")

    outline = CucumberAnalytics::ParsedScenarioOutline.new(source)
    example = outline.examples.first
    step = outline.steps.first

    example.parent_element.should equal outline
    step.parent_element.should equal outline
  end

end
