require 'spec_helper'

SimpleCov.command_name('ParsedFile') unless RUBY_VERSION.to_s < '1.9.0'

describe "ParsedFile" do

  it 'knows its parent element' do
    file_path = "#{@default_file_directory}/#{@default_feature_file_name}"

    File.open(file_path, "w") { |file|
      file.puts('Feature: Test feature')
    }

    directory = CucumberAnalytics::ParsedDirectory.new(@default_file_directory)
    file = directory.feature_files.first

    file.parent_element.should equal directory
  end

end