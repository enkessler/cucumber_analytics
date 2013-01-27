require 'spec_helper'

SimpleCov.command_name('ParsedScenario') unless RUBY_VERSION.to_s < '1.9.0'

describe "ParsedScenario" do

  it "knows all of its tags" do
    feature = CucumberAnalytics::ParsedFeature.new
    feature.tags = ['@feature_tag']
    scenario = CucumberAnalytics::ParsedScenario.new
    scenario.tags = ['@scenario_tag']

    scenario.parent_element = feature
    scenario.all_tags.sort.should == ['@feature_tag', '@scenario_tag'].sort
  end

end