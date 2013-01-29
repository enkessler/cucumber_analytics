require 'spec_helper'

SimpleCov.command_name('ParsedFeature') unless RUBY_VERSION.to_s < '1.9.0'

describe "ParsedFeature" do

  it 'knows its parent element' do
    file_path = "#{@default_file_directory}/#{@default_feature_file_name}"

    File.open(file_path, "w") { |file|
      file.puts('Feature: Test feature')
    }

    file = CucumberAnalytics::ParsedFile.new(file_path)
    feature = file.feature

    feature.parent_element.should equal file
  end

end