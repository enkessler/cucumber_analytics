require 'spec_helper'

shared_examples_for 'a sourced element' do |clazz|

  before(:each) do
    @element = clazz.new
  end


  it 'has a source line - #source_line' do
    expect(@element.respond_to?(:source_line)).to be true
  end

  it 'starts with no source line' do
    expect(@element.source_line).to be_nil
  end

end
