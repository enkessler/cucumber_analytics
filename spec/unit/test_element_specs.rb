require 'spec_helper'

shared_examples_for 'a test element' do |clazz|

  before(:each) do
    @element = clazz.new
  end

  it 'has steps - #steps' do
     @element.should respond_to(:steps)
   end

  it 'contains steps - #contains' do
    steps = [:step_1, :step_2, :step_3]
    @element.steps = steps

    steps.each {|step| @element.contains.should include(step)}
  end

end
