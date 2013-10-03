require 'spec_helper'

SimpleCov.command_name('DocString') unless RUBY_VERSION.to_s < '1.9.0'

describe 'DocString, Integration' do

  context 'getting stuff' do

    before(:each) do
      source = ['Feature: Test feature',
                '',
                '  Scenario: Test test',
                '    * a big step:',
                '  """',
                '  a',
                '  doc',
                '  string',
                '  """']
      source = source.join("\n")

      file_path = "#{@default_file_directory}/doc_string_test_file.feature"
      File.open(file_path, 'w') { |file| file.write(source) }

      @directory = CucumberAnalytics::Directory.new(@default_file_directory)
      @doc_string = @directory.feature_files.first.features.first.tests.first.steps.first.block
    end


    it 'can get its directory' do
      directory = @doc_string.get_ancestor(:directory)

      directory.path.should == @directory.path
    end

    it 'can get its feature file' do
      feature_file = @doc_string.get_ancestor(:feature_file)

      feature_file.path.should == @directory.feature_files.first.path
    end

    it 'can get its feature' do
      feature = @doc_string.get_ancestor(:feature)

      feature.name.should == @directory.feature_files.first.features.first.name
    end

    it 'can get its test' do
      test = @doc_string.get_ancestor(:test)

      test.name.should == @directory.feature_files.first.features.first.tests.first.name
    end

    it 'can get its step' do
      step = @doc_string.get_ancestor(:step)

      step.base.should == @directory.feature_files.first.features.first.tests.first.steps.first.base
    end

    it 'returns nil if it does not have the requested type of ancestor' do
      example = @doc_string.get_ancestor(:example)

      example.should be_nil
    end

  end
end
