require 'spec_helper'

SimpleCov.command_name('Scenario') unless RUBY_VERSION.to_s < '1.9.0'

describe 'Scenario, Unit' do

  clazz = CucumberAnalytics::Scenario

  it_should_behave_like 'a feature element', clazz
  it_should_behave_like 'a nested element', clazz
  it_should_behave_like 'a containing element', clazz
  it_should_behave_like 'a tagged element', clazz
  it_should_behave_like 'a bare bones element', clazz
  it_should_behave_like 'a prepopulated element', clazz
  it_should_behave_like 'a test element', clazz

  it 'can be parsed from stand alone text' do
    source = 'Scenario: '

    expect { clazz.new(source) }.to_not raise_error
  end

  before(:each) do
    @scenario = clazz.new
  end

  it 'contains only steps' do
    steps = [:step_1, :step_2]
    everything = steps

    @scenario.steps = steps

    @scenario.contains.should =~ everything
  end

end
