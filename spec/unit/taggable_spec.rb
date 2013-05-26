require 'spec_helper'

SimpleCov.command_name('Taggable') unless RUBY_VERSION.to_s < '1.9.0'

describe "Taggable, Unit" do

  nodule = CucumberAnalytics::Taggable

  before(:each) do
    @element = Object.new.extend(nodule)

    def @element.parent_element
      @parent_element
    end

    def @element.parent_element=(parent)
      @parent_element = parent
    end
  end


  it 'has tags - #tags' do
    @element.should respond_to(:tags)
  end

  it 'can get and set its tags - #tags, #tags=' do
    @element.tags = :some_tags
    @element.tags.should == :some_tags
    @element.tags = :some_other_tags
    @element.tags.should == :some_other_tags
  end

  it 'has applied tags - #applied_tags' do
    @element.should respond_to(:applied_tags)
  end

  it 'inherits its applied tags from its ancestors - #applied_tags' do
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

  it 'may have no applied tags' do
    @element.parent_element = :not_a_tagged_object

    @element.applied_tags.should == []
  end

end
