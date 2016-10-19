require "#{File.dirname(__FILE__)}/../spec_helper"

shared_examples_for 'a feature element' do |clazz|

  before(:each) do
    @element = clazz.new
  end

  it 'has a name - #name' do
    expect(@element.respond_to?(:name)).to be true
  end

  it 'can get and set its name - #name, #name=' do
    @element.name = :some_name
    expect(@element.name).to eq(:some_name)
    @element.name = :some_other_name
    expect(@element.name).to eq(:some_other_name)
  end

  it 'has a description' do
    expect(@element.respond_to?(:description)).to be true
    expect(@element.respond_to?(:description_text)).to be true
  end

  it 'can get and set its description' do
    @element.description = :some_description
    expect(@element.description).to eq(:some_description)
    @element.description = :some_other_description
    expect(@element.description).to eq(:some_other_description)

    @element.description_text = :some_description
    expect(@element.description_text).to eq(:some_description)
    @element.description_text = :some_other_description
    expect(@element.description_text).to eq(:some_other_description)
  end

  it 'starts with no name' do
    expect(@element.name).to eq('')
  end

  it 'starts with no description' do
    expect(@element.description).to eq([])
    expect(@element.description_text).to eq('')
  end

end
