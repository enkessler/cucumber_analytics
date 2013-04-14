require 'spec_helper'

SimpleCov.command_name('ParsedBackground') unless RUBY_VERSION.to_s < '1.9.0'

describe "ParsedBackground" do

  it 'properly sets its child elements' do
    file_path = "#{@default_file_directory}/#{@default_feature_file_name}"

    File.open(file_path, "w") { |file|
      file.puts('Feature: Test feature')
      file.puts('  Background: Test background')
      file.puts('    * a step')
    }

    background = CucumberAnalytics::ParsedFile.new(file_path).feature.background
    step = background.steps.first

    step.parent_element.should equal background
  end

end
