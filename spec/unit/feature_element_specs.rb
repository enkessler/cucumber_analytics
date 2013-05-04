require 'spec_helper'

shared_examples_for 'a feature element' do |clazz|

  before(:each) do
    @element = clazz.new
  end

  it 'has a name - #name, #name=' do
    @element.should respond_to(:name)
    @element.should respond_to(:name=)
  end

  it 'has a description - #description, #description=' do
    @element.should respond_to(:description)
    @element.should respond_to(:description=)
  end

end
