require "#{File.dirname(__FILE__)}/../spec_helper"

shared_examples_for 'a containing element' do |clazz|

  before(:each) do
    @element = clazz.new
  end

  it 'has children - #contains' do
    expect(@element.respond_to?(:contains)).to be true
  end

  it 'returns a collection of children - #contains' do
    expect(@element.contains).to be_a(Array)
  end

end
