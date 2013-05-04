require 'spec_helper'

SimpleCov.command_name('Directory') unless RUBY_VERSION.to_s < '1.9.0'

describe "Directory Integration" do

  it 'properly sets its child elements' do
    nested_directory = "#{@default_file_directory}/nested_directory"
    file_path = "#{@default_file_directory}/#{@default_feature_file_name}"

    FileUtils.mkdir(nested_directory)
    File.open(file_path, "w") { |file|
      file.puts('Feature: Test feature')
    }

    directory = CucumberAnalytics::Directory.new(@default_file_directory)
    nested_directory = directory.directories.first
    file = directory.feature_files.first

    nested_directory.parent_element.should equal directory
    file.parent_element.should equal directory
  end

end
