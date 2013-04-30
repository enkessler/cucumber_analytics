require 'spec_helper'

SimpleCov.command_name('Scenario') unless RUBY_VERSION.to_s < '1.9.0'

describe "Scenario" do

  it 'properly sets its child elements' do
    source = ['Scenario: Test scenario',
              '  * a step']
    source = source.join("\n")

    scenario = CucumberAnalytics::Scenario.new(source)
    step = scenario.steps.first

    step.parent_element.should equal scenario
  end

end
