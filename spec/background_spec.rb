require 'spec_helper'

SimpleCov.command_name('ParsedBackground') unless RUBY_VERSION.to_s < '1.9.0'

describe "ParsedBackground" do

  it 'knows its parent element' do
    file_path = "#{@default_file_directory}/#{@default_feature_file_name}"

    File.open(file_path, "w") { |file|
      file.puts('Feature: Test feature')
      file.puts('  Background: Test background')
    }

    file = CucumberAnalytics::ParsedFile.new(file_path)

    feature = file.feature
    background = feature.background

    background.parent_element.should equal feature
  end

end