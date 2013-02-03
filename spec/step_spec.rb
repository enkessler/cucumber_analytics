require 'spec_helper'

SimpleCov.command_name('Step') unless RUBY_VERSION.to_s < '1.9.0'

describe 'Step' do

  it 'knows its parent element' do
    file_path = "#{@default_file_directory}/#{@default_feature_file_name}"

    File.open(file_path, "w") { |file|
      file.puts('Feature: Test feature')
      file.puts('  Scenario: Test scenario')
      file.puts('    Given a test step')
    }

    file = CucumberAnalytics::ParsedFile.new(file_path)

    scenario = file.feature.tests.first
    step = scenario.steps.first

    step.parent_element.should equal scenario
  end

end