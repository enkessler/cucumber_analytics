require 'spec_helper'

shared_examples_for 'a nested element' do |clazz|

  before(:each) do
    @nested_element = clazz.new
  end

  it 'has a parent element - #parent_element, #parent_element=' do
    @nested_element.should respond_to(:parent_element)
    @nested_element.should respond_to(:parent_element=)
  end

end
