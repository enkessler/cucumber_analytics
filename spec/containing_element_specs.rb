require 'spec_helper'

shared_examples_for 'a containing element' do |clazz|

  before(:each) do
    @element = clazz.new
  end

  it 'has children - #contains' do
    @element.should respond_to(:contains)
  end

end
