require "#{File.dirname(__FILE__)}/../spec_helper"

SimpleCov.command_name('Tag') unless RUBY_VERSION.to_s < '1.9.0'

describe 'Tag, Integration' do

  context 'getting stuff' do

    before(:each) do
      source = ['@feature_tag',
                'Feature: Test feature',
                '',
                '  Scenario Outline: Test test',
                '    * a step',
                '',
                '  @example_tag',
                '  Examples: Test example',
                '    | a param |']
      source = source.join("\n")

      file_path = "#{@default_file_directory}/tag_test_file.feature"
      File.open(file_path, 'w') { |file| file.write(source) }

      @directory = CucumberAnalytics::Directory.new(@default_file_directory)
      @tag = @directory.feature_files.first.features.first.tests.first.examples.first.tag_elements.first
      @high_level_tag = @directory.feature_files.first.features.first.tag_elements.first
    end


    it 'can get its directory' do
      directory = @tag.get_ancestor(:directory)

      expect(directory).to be(@directory)
    end

    it 'can get its feature file' do
      feature_file = @tag.get_ancestor(:feature_file)

      expect(feature_file).to be(@directory.feature_files.first)
    end

    it 'can get its feature' do
      feature = @tag.get_ancestor(:feature)

      expect(feature).to be(@directory.feature_files.first.features.first)
    end

    it 'can get its test' do
      test = @tag.get_ancestor(:test)

      expect(test).to be(@directory.feature_files.first.features.first.tests.first)
    end

    it 'can get its example' do
      example = @tag.get_ancestor(:example)

      expect(example).to be(@directory.feature_files.first.features.first.tests.first.examples.first)
    end

    it 'returns nil if it does not have the requested type of ancestor' do
      example = @high_level_tag.get_ancestor(:example)

      expect(example).to be_nil
    end

  end
end
