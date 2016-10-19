require 'spec_helper'

SimpleCov.command_name('Nested') unless RUBY_VERSION.to_s < '1.9.0'

describe 'Nested, Unit' do

  nodule = CucumberAnalytics::Nested

  before(:each) do
    @nested_element = Object.new.extend(nodule)
  end


  it 'has a parent element - #parent_element' do
    expect(@nested_element.respond_to?(:parent_element)).to be true
  end

  it 'can get and set its parent element - #parent_element, #parent_element=' do
    @nested_element.parent_element = :some_parent_element
    expect(@nested_element.parent_element).to eq(:some_parent_element)
    @nested_element.parent_element = :some_other_parent_element
    expect(@nested_element.parent_element).to eq(:some_other_parent_element)
  end

  it 'has access to its ancestors' do
    expect(@nested_element.respond_to?(:get_ancestor)).to be true
  end

  it 'gets an ancestor based on type' do
    expect(nodule.instance_method(:get_ancestor).arity == 1).to be true
  end

  it 'raises and exception if an unknown ancestor type is requested' do
    expect { @nested_element.get_ancestor(:bad_ancestor_type) }.to raise_exception(ArgumentError)
  end

end
