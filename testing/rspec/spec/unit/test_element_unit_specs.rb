require 'spec_helper'

shared_examples_for 'a test element' do |clazz|

  before(:each) do
    @element = clazz.new
  end

  it 'has steps - #steps' do
    expect(@element.respond_to?(:steps)).to be true
  end

  it 'can get and set its steps - #steps, #steps=' do
    @element.steps = :some_steps
    expect(@element.steps).to eq(:some_steps)
    @element.steps = :some_other_steps
    expect(@element.steps).to eq(:some_other_steps)
  end

  it 'starts with no steps' do
    expect(@element.steps).to eq([])
  end

  it 'contains steps - #contains' do
    steps = [:step_1, :step_2, :step_3]
    @element.steps = steps

    steps.each { |step| expect(@element.contains).to include(step) }
  end

end
