require 'spec_helper'

SimpleCov.command_name('Feature') unless RUBY_VERSION.to_s < '1.9.0'

describe "Feature" do

  it 'properly sets its child elements' do
    source = ['Feature: Test feature',
              '  Background: Test background',
              '  Scenario: Test scenario',
              '  Scenario Outline: Test outline']
    source = source.join("\n")


    feature = CucumberAnalytics::Feature.new(source)
    background = feature.background
    scenario = feature.tests.first
    outline = feature.tests.last


    outline.parent_element.should equal feature
    scenario.parent_element.should equal feature
    background.parent_element.should equal feature
  end

end
