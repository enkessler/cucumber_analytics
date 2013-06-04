require 'spec_helper'

SimpleCov.command_name('Step') unless RUBY_VERSION.to_s < '1.9.0'

describe 'Step, Integration' do

  it 'defaults to the World delimiters if its own are not set' do
    world = CucumberAnalytics::World
    world.left_delimiter = '"'
    world.right_delimiter = '"'

    step = CucumberAnalytics::Step.new
    step.right_delimiter = nil
    step.left_delimiter = nil

    step.right_delimiter.should == '"'
    step.left_delimiter.should == '"'
  end

  it 'attempts to determine its arguments during creation' do
    source = 'Given a test step with *parameter 1* and "parameter 2" and *parameter 3*'

    world = CucumberAnalytics::World
    world.left_delimiter = '"'
    world.right_delimiter = '"'

    step = CucumberAnalytics::Step.new(source)

    step.arguments.should == ['parameter 2']
  end

  it 'finds nothing when no regular expression or delimiters are available' do
    world = CucumberAnalytics::World
    world.left_delimiter = nil
    world.right_delimiter = nil

    source = 'Given a test step with *parameter 1* and "parameter 2" and *parameter 3*'
    step = CucumberAnalytics::Step.new(source)

    step.scan_arguments

    step.arguments.should == []
  end

end
