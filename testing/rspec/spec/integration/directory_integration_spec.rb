require "#{File.dirname(__FILE__)}/../spec_helper"

SimpleCov.command_name('Directory') unless RUBY_VERSION.to_s < '1.9.0'

describe 'Directory, Integration' do

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

    expect(nested_directory.parent_element).to be(directory)
    expect(file.parent_element).to be(directory)
  end

  context 'getting stuff' do

    before(:each) do
      nested_directory = "#{@default_file_directory}/nested_directory"
      FileUtils.mkdir(nested_directory)

      @directory = CucumberAnalytics::Directory.new(@default_file_directory)
      @nested_directory = @directory.directories.first
    end


    it 'can get its directory' do
      directory = @nested_directory.get_ancestor(:directory)

      expect(directory).to be(@directory)
    end

    it 'returns nil if it does not have the requested type of ancestor' do
      example = @nested_directory.get_ancestor(:example)

      expect(example).to be_nil
    end

  end
end
