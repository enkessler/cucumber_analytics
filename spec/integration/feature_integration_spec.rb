require 'spec_helper'

SimpleCov.command_name('Feature') unless RUBY_VERSION.to_s < '1.9.0'

describe 'Feature, Integration' do

  clazz = CucumberAnalytics::Feature

  before(:each) do
    @feature = clazz.new
  end

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

  it 'can distinguish scenarios from outlines - #scenarios, #outlines' do
    scenarios = [CucumberAnalytics::Scenario.new('Scenario: 1'), CucumberAnalytics::Scenario.new('Scenario: 2')]
    outlines = [CucumberAnalytics::Outline.new('Scenario Outline: 1'), CucumberAnalytics::Outline.new('Scenario Outline: 2')]

    @feature.tests = scenarios + outlines

    @feature.scenarios.should =~ scenarios
    @feature.outlines.should =~ outlines
  end

  it 'knows how many scenarios it has - #scenario_count' do
    scenarios = [CucumberAnalytics::Scenario.new('Scenario: 1'), CucumberAnalytics::Scenario.new('Scenario: 2')]
    outlines = [CucumberAnalytics::Outline.new('Scenario Outline: 1')]

    @feature.tests = []
    @feature.scenario_count.should == 0

    @feature.tests = scenarios + outlines
    @feature.scenario_count.should == 2
  end

  it 'knows how many outlines it has - #outline_count' do
    scenarios = [CucumberAnalytics::Scenario.new('Scenario: 1')]
    outlines = [CucumberAnalytics::Outline.new('Scenario Outline: 1'), CucumberAnalytics::Outline.new('Scenario Outline: 2')]

    @feature.tests = []
    @feature.outline_count.should == 0

    @feature.tests = scenarios + outlines
    @feature.outline_count.should == 2
  end

  it 'knows how many test cases it has - #test_case_count' do
    source_1 = ['Feature: Test feature']
    source_1 = source_1.join("\n")

    source_2 = ['Feature: Test feature',
              '  Scenario: Test scenario',
              '  Scenario Outline: Test outline',
              '    * a step',
              '  Examples: Test examples',
              '    |param|',
              '    |value_1|',
              '    |value_2|']
    source_2 = source_2.join("\n")

    feature_1 = CucumberAnalytics::Feature.new(source_1)
    feature_2 = CucumberAnalytics::Feature.new(source_2)


    feature_1.test_case_count.should == 0
    feature_2.test_case_count.should == 3
  end

end
