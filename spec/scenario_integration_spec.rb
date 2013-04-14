require 'spec_helper'

SimpleCov.command_name('ParsedScenario') unless RUBY_VERSION.to_s < '1.9.0'

describe "ParsedScenario" do

  it 'properly sets its child elements' do
    file_path = "#{@default_file_directory}/#{@default_feature_file_name}"

    File.open(file_path, "w") { |file|
      file.puts('Feature: Test feature')
      file.puts('  Scenario: Test scenario')
      file.puts('    * a step')
    }

    scenario = CucumberAnalytics::ParsedFile.new(file_path).feature.tests.first
    step = scenario.steps.first

    step.parent_element.should equal scenario
  end

end
