require "#{File.dirname(__FILE__)}/../spec_helper"

SimpleCov.command_name('TestElement') unless RUBY_VERSION.to_s < '1.9.0'

describe 'TestElement, Unit' do

  clazz = CucumberAnalytics::TestElement

  it_should_behave_like 'a test element', clazz
  it_should_behave_like 'a feature element', clazz
  it_should_behave_like 'a nested element', clazz
  it_should_behave_like 'a prepopulated element', clazz
  it_should_behave_like 'a bare bones element', clazz


  before(:each) do
    @element = clazz.new
  end

  it 'contains only steps - #contains' do
    steps = [:step_1, :step_2, :step_3]
    @element.steps = steps

    expect(@element.contains).to match_array(steps)
  end

  it 'can determine its equality with another TestElement - #==' do
    element_1 = clazz.new
    element_2 = clazz.new
    element_3 = clazz.new

    element_1.steps = :some_steps
    element_2.steps = :some_steps
    element_3.steps = :some_other_steps

    expect(element_1).to eq(element_2)
    expect(element_1).to_not eq(element_3)
  end

  it 'can gracefully be compared to other types of objects' do
    # Some common types of object
    [1, 'foo', :bar, [], {}].each do |thing|
      expect { @element == thing }.to_not raise_error
      expect(@element == thing).to be false
    end
  end

end
