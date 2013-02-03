require 'spec_helper'

SimpleCov.command_name('ParsedScenario') unless RUBY_VERSION.to_s < '1.9.0'

describe "ParsedScenario" do

  it "knows all of its tags" do
    feature = CucumberAnalytics::ParsedFeature.new
    feature.tags = ['@feature_tag']
    scenario = CucumberAnalytics::ParsedScenario.new
    scenario.tags = ['@scenario_tag']

    scenario.parent_element = feature
    scenario.all_tags.sort.should == ['@feature_tag', '@scenario_tag'].sort
  end

  it 'knows its parent element' do
    file_path = "#{@default_file_directory}/#{@default_feature_file_name}"

    File.open(file_path, "w") { |file|
      file.puts('Feature: Test feature')
      file.puts('  Scenario: Test scenario')
    }

    file = CucumberAnalytics::ParsedFile.new(file_path)

    feature = file.feature
    scenario = feature.tests.first

    scenario.parent_element.should equal feature
  end

end