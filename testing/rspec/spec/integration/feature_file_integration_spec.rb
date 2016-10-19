require 'spec_helper'

SimpleCov.command_name('FeatureFile') unless RUBY_VERSION.to_s < '1.9.0'

describe 'FeatureFile, Integration' do

  it 'properly sets its child elements' do
    file_path = "#{@default_file_directory}/#{@default_feature_file_name}"

    File.open(file_path, "w") { |file|
      file.puts('Feature: Test feature')
    }

    file = CucumberAnalytics::FeatureFile.new(file_path)
    feature = file.feature

    expect(feature.parent_element).to be(file)
  end

  context 'getting stuff' do

    before(:each) do
      file_path = "#{@default_file_directory}/feature_file_test_file.feature"
      File.open(file_path, 'w') { |file| file.write('Feature: Test feature') }

      @directory = CucumberAnalytics::Directory.new(@default_file_directory)
      @feature_file = @directory.feature_files.first
    end


    it 'can get its directory' do
      directory = @feature_file.get_ancestor(:directory)

      expect(directory).to be(@directory)
    end

    it 'returns nil if it does not have the requested type of ancestor' do
      example = @feature_file.get_ancestor(:example)

      expect(example).to be_nil
    end

  end
end
