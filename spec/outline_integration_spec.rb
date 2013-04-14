require 'spec_helper'

SimpleCov.command_name('ParsedOutline') unless RUBY_VERSION.to_s < '1.9.0'

describe 'ParsedOutline' do

  it 'properly sets its child elements' do
    file_path = "#{@default_file_directory}/#{@default_feature_file_name}"

    File.open(file_path, 'w') { |file|
      file.puts('Feature: Test feature')
      file.puts('  Scenario Outline:')
      file.puts('    * a step')
      file.puts('  Examples:')
      file.puts('    | param |')
    }

    outline = CucumberAnalytics::ParsedFile.new(file_path).feature.tests.first
    example = outline.examples.first
    step = outline.steps.first

    example.parent_element.should equal outline
    step.parent_element.should equal outline
  end

end
