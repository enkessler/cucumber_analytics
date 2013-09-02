require 'spec_helper'

SimpleCov.command_name('Scenario') unless RUBY_VERSION.to_s < '1.9.0'

describe 'Scenario, Integration' do

  it 'properly sets its child elements' do
    source = ['@a_tag',
              'Scenario: Test scenario',
              '  * a step']
    source = source.join("\n")

    scenario = CucumberAnalytics::Scenario.new(source)
    step = scenario.steps.first
    tag = scenario.tag_elements.first

    step.parent_element.should equal scenario
    tag.parent_element.should equal scenario
  end

end
