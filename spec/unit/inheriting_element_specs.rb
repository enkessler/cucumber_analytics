require 'spec_helper'

shared_examples_for 'an inheriting element' do |clazz|

  before(:each) do
    @element = clazz.new
  end

  it 'has inherited tags - #applied_tags' do
    @element.should respond_to(:applied_tags)
  end

  it 'inherits tags from its ancestors - #applied_tags' do
    all_parent_tags = ['@parent_tag_1', '@parent_tag_2', '@grandparent_tag_1']
    parent = double(:all_tags => all_parent_tags)

    @element.parent_element = parent

    @element.applied_tags.should == all_parent_tags
  end

  it 'knows all of its applicable tags - #all_tags' do
    all_parent_tags = ['@parent_tag_1', '@parent_tag_2', '@grandparent_tag_1']
    own_tags = ['@tag_1', '@tag_2']
    parent = double(:all_tags => all_parent_tags)

    @element.parent_element = parent
    @element.tags = own_tags

    @element.all_tags.should == all_parent_tags + own_tags
  end

end
