require 'spec_helper'

shared_examples_for 'a nested element' do |clazz|

  before(:each) do
    @nested_element = clazz.new
  end

  it 'has a parent element - #parent_element' do
    @nested_element.should respond_to(:parent_element)
  end

   it 'can get and set its parent element - #parent_element, #parent_element=' do
     @nested_element.parent_element = :some_parent_element
     @nested_element.parent_element.should == :some_parent_element
     @nested_element.parent_element = :some_other_parent_element
     @nested_element.parent_element.should == :some_other_parent_element
   end

  it 'starts with no parent element' do
    @nested_element.parent_element.should == nil
  end

end
