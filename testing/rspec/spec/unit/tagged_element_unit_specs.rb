require "#{File.dirname(__FILE__)}/../spec_helper"

shared_examples_for 'a tagged element' do |clazz|

  before(:each) do
    @element = clazz.new
  end

  it 'has tags' do
    expect(@element.respond_to?(:tags)).to be true
    expect(@element.respond_to?(:tag_elements)).to be true
  end

  it 'can get and set its tags' do
    @element.tags = :some_tags
    expect(@element.tags).to eq(:some_tags)
    @element.tags = :some_other_tags
    expect(@element.tags).to eq(:some_other_tags)

    @element.tag_elements = :some_tag_elements
    expect(@element.tag_elements).to eq(:some_tag_elements)
    @element.tag_elements = :some_other_tag_elements
    expect(@element.tag_elements).to eq(:some_other_tag_elements)
  end

  it 'starts with no tags' do
    expect(@element.tags).to eq([])
    expect(@element.tag_elements).to eq([])
  end

  it 'has applied tags' do
    expect(@element.respond_to?(:applied_tags)).to be true
    expect(@element.respond_to?(:applied_tag_elements)).to be true
  end

  it 'inherits its applied tags from its ancestors' do
    all_parent_tag_elements = [:parent_tag_element_1, :parent_tag_element_2, :grandparent_tag_element_1]
    all_parent_tags = ['@parent_tag_1', '@parent_tag_2', '@grandparent_tag_1']
    parent = double(:all_tags => all_parent_tags, :all_tag_elements => all_parent_tag_elements)

    @element.parent_element = parent

    expect(@element.applied_tags).to eq(all_parent_tags)
    expect(@element.applied_tag_elements).to eq(all_parent_tag_elements)
  end

  it 'knows all of its applicable tags' do
    all_parent_tag_elements = [:parent_tag_element_1, :parent_tag_element_2, :grandparent_tag_element_1]
    all_parent_tags = ['@parent_tag_1', '@parent_tag_2', '@grandparent_tag_1']
    own_tags = ['@tag_1', '@tag_2']
    own_tag_elements = [:tag_element_1, :tag_element_2]

    parent = double(:all_tags => all_parent_tags, :all_tag_elements => all_parent_tag_elements)

    @element.parent_element = parent
    @element.tags = own_tags
    @element.tag_elements = own_tag_elements

    expect(@element.all_tags).to eq(all_parent_tags + own_tags)
    expect(@element.all_tag_elements).to eq(all_parent_tag_elements + own_tag_elements)
  end

end
