require 'spec_helper'

SimpleCov.command_name('ParsedDirectory') unless RUBY_VERSION.to_s < '1.9.0'

describe "ParsedDirectory" do

  it 'knows its parent element' do
    directory = @default_file_directory
    nested_directory = "#{directory}/nested_directory"
    FileUtils.mkdir(nested_directory)

    directory = CucumberAnalytics::ParsedDirectory.new(@default_file_directory)
    nested_directory = directory.feature_directories.first

    nested_directory.parent_element.should equal directory
  end

end