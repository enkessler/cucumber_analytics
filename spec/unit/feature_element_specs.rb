require 'spec_helper'

shared_examples_for 'a feature element' do |clazz|

  before(:each) do
    @element = clazz.new
  end

  it 'has a name - #name' do
    @element.should respond_to(:name)
  end

  it 'can get and set its name - #name, #name=' do
    @element.name = :some_name
    @element.name.should == :some_name
    @element.name = :some_other_name
    @element.name.should == :some_other_name
  end

  it 'has a description - #description' do
    @element.should respond_to(:description)
  end

  it 'can get and set its description - #description, #description=' do
    @element.description = :some_description
    @element.description.should == :some_description
    @element.description = :some_other_description
    @element.description.should == :some_other_description
  end

  it 'starts with no name' do
    @element.name.should == ''
  end

  it 'starts with no description' do
    @element.description.should == []
  end

end
