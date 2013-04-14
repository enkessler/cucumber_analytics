require 'spec_helper'

SimpleCov.command_name('ParsedFeature') unless RUBY_VERSION.to_s < '1.9.0'

describe "ParsedFeature" do

  it 'properly sets its child elements' do
    file_path = "#{@default_file_directory}/#{@default_feature_file_name}"

    File.open(file_path, "w") { |file|
      file.puts('Feature: Test feature')
      file.puts('  Background: Test background')
      file.puts('  Scenario: Test scenario')
      file.puts('  Scenario Outline: Test outline')
    }


    file = CucumberAnalytics::ParsedFile.new(file_path)
    feature = file.feature
    background = feature.background
    scenario = feature.tests.first
    outline = feature.tests.last


    outline.parent_element.should equal feature
    scenario.parent_element.should equal feature
    background.parent_element.should equal feature
  end

end
