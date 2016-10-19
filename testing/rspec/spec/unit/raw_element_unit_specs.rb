require 'spec_helper'

shared_examples_for 'a raw element' do |clazz|

  before(:each) do
    @element = clazz.new
  end

  it 'has an underlying implementation representation - #raw_element' do
    expect(@element.respond_to?(:raw_element)).to be true
  end

  it 'can get and set its underlying implementation representation - #raw_element, #raw_element=' do
    @element.raw_element = :some_raw_element
    expect(@element.raw_element).to eq(:some_raw_element)
    @element.raw_element = :some_other_raw_element
    expect(@element.raw_element).to eq(:some_other_raw_element)
  end

  it 'starts with no underlying implementation representation' do
    expect(@element.raw_element).to be_nil
  end

end
