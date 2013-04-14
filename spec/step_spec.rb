require 'spec_helper'

SimpleCov.command_name('Step') unless RUBY_VERSION.to_s < '1.9.0'

describe 'Step' do

  clazz = CucumberAnalytics::Step

  it_should_behave_like 'a nested element', clazz
  it_should_behave_like 'a bare bones element', clazz

  it 'can determine its arguments based on delimiters' do
    file_path = "#{@default_file_directory}/#{@default_feature_file_name}"

    File.open(file_path, "w") { |file|
      file.puts('Feature: Test feature')
      file.puts('  Scenario: Test scenario')
      file.puts('    Given a test step with *parameter 1* and !parameter 2- and *parameter 3*')
    }

    file = CucumberAnalytics::ParsedFile.new(file_path)

    step = file.feature.tests.first.steps.first

    step.scan_arguments('*', '*')
    step.arguments.should == ['parameter 1', 'parameter 3']
    step.scan_arguments('!', '-')
    step.arguments.should == ['parameter 2']
    step.scan_arguments('!', '!')
    step.arguments.should == []
  end

  it 'defaults to the World delimiters when scanning' do
    file_path = "#{@default_file_directory}/#{@default_feature_file_name}"

    File.open(file_path, "w") { |file|
      file.puts('Feature: Test feature')
      file.puts('  Scenario: Test scenario')
      file.puts('    Given a test step with *parameter 1* and "parameter 2" and *parameter 3*')
    }

    world = CucumberAnalytics::World
    world.left_delimiter = '"'
    world.right_delimiter = '"'

    file = CucumberAnalytics::ParsedFile.new(file_path)
    step = file.feature.tests.first.steps.first

    step.scan_arguments
    step.arguments.should == ['parameter 2']
  end

  it 'attempts to determine its arguments during creation' do
    file_path = "#{@default_file_directory}/#{@default_feature_file_name}"

    File.open(file_path, "w") { |file|
      file.puts('Feature: Test feature')
      file.puts('  Scenario: Test scenario')
      file.puts('    Given a test step with *parameter 1* and "parameter 2" and *parameter 3*')
    }

    world = CucumberAnalytics::World
    world.left_delimiter = '"'
    world.right_delimiter = '"'

    file = CucumberAnalytics::ParsedFile.new(file_path)
    step = file.feature.tests.first.steps.first

    step.arguments.should == ['parameter 2']
  end

end
