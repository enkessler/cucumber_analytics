require 'spec_helper'

SimpleCov.command_name('Outline') unless RUBY_VERSION.to_s < '1.9.0'

describe 'Outline' do

  it 'properly sets its child elements' do
    source = ['  Scenario Outline:',
              '    * a step',
              '  Examples:',
              '    | param |']
    source = source.join("\n")

    outline = CucumberAnalytics::Outline.new(source)
    example = outline.examples.first
    step = outline.steps.first

    example.parent_element.should equal outline
    step.parent_element.should equal outline
  end

end
