require 'spec_helper'

SimpleCov.command_name('Step') unless RUBY_VERSION.to_s < '1.9.0'

describe 'Step' do

  clazz = CucumberAnalytics::Step

  it_should_behave_like 'a nested element', clazz
  it_should_behave_like 'a bare bones element', clazz

  it 'can determine its arguments based on delimiters' do
    source = 'Given a test step with *parameter 1* and !parameter 2- and *parameter 3*'

    step = CucumberAnalytics::Step.new(source)

    step.scan_arguments('*', '*')
    step.arguments.should == ['parameter 1', 'parameter 3']
    step.scan_arguments('!', '-')
    step.arguments.should == ['parameter 2']
    step.scan_arguments('!', '!')
    step.arguments.should == []
  end

  it 'defaults to the World delimiters when scanning' do
    source = 'Given a test step with *parameter 1* and "parameter 2" and *parameter 3*'

    world = CucumberAnalytics::World
    world.left_delimiter = '"'
    world.right_delimiter = '"'

    step = CucumberAnalytics::Step.new(source)

    step.scan_arguments
    step.arguments.should == ['parameter 2']
  end

  it 'attempts to determine its arguments during creation' do
    source = 'Given a test step with *parameter 1* and "parameter 2" and *parameter 3*'

    world = CucumberAnalytics::World
    world.left_delimiter = '"'
    world.right_delimiter = '"'

    step = CucumberAnalytics::Step.new(source)

    step.arguments.should == ['parameter 2']
  end

  it 'can be parsed from stand alone text' do
    source = '* some step'

    expect { clazz.new(source) }.to_not raise_error
  end

end
