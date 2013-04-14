require 'spec_helper'

shared_examples_for 'a tagged element' do |clazz|

  before(:each) do
    @element = clazz.new
  end

  it 'has tags - #tags, #all_tags' do
    @element.should respond_to(:tags)
    @element.should respond_to(:all_tags)
  end

end
