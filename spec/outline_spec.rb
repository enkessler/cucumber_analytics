require 'spec_helper'

SimpleCov.command_name('ParsedOutline') unless RUBY_VERSION.to_s < '1.9.0'

describe "ParsedOutline" do

  it "knows all of its tags" do
    feature = CucumberAnalytics::ParsedFeature.new
    feature.tags = ['@feature_tag']
    outline = CucumberAnalytics::ParsedScenarioOutline.new
    outline.tags = ['@outline_tag']

    outline.parent_element = feature
    outline.all_tags.sort.should == ['@feature_tag', '@outline_tag'].sort
  end

end