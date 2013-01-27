require 'spec_helper'

SimpleCov.command_name('OutlineExample') unless RUBY_VERSION.to_s < '1.9.0'

describe "OutlineExample" do

  it "knows all of its tags" do
    feature = CucumberAnalytics::ParsedFeature.new
    feature.tags = ['@feature_tag']
    outline = CucumberAnalytics::ParsedScenarioOutline.new
    outline.tags = ['@outline_tag']
    example = CucumberAnalytics::OutlineExample.new
    example.tags = ['@example_tag']

    outline.parent_element = feature
    example.parent_element = outline
    example.all_tags.sort.should == ['@feature_tag', '@outline_tag', '@example_tag'].sort
  end

end