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

  it 'knows its parent element' do
    file_path = "#{@default_file_directory}/#{@default_feature_file_name}"

    File.open(file_path, "w") { |file|
      file.puts('Feature: Test feature')
      file.puts('  Scenario Outline: Test outline')
      file.puts('  Examples: test examples')
    }

    file = CucumberAnalytics::ParsedFile.new(file_path)

    outline = file.feature.tests.first
    example = outline.examples.first

    example.parent_element.should equal outline
  end

end