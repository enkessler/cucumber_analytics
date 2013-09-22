require 'spec_helper'

SimpleCov.command_name('Background') unless RUBY_VERSION.to_s < '1.9.0'

describe 'Background, Integration' do

  it 'properly sets its child elements' do
    source = ['  Background: Test background',
              '    * a step']
    source = source.join("\n")

    background = CucumberAnalytics::Background.new(source)
    step = background.steps.first

    step.parent_element.should equal background
  end

  context 'getting stuff' do

    before(:each) do
      source = ['Feature: Test feature',
                '',
                '  Background: Test background',
                '    * a step:']
      source = source.join("\n")

      file_path = "#{@default_file_directory}/background_test_file.feature"
      File.open(file_path, 'w') { |file| file.write(source) }

      @directory = CucumberAnalytics::Directory.new(@default_file_directory)
      @background = @directory.feature_files.first.features.first.background
    end


    it 'can get its directory' do
      directory = @background.get_ancestor(:directory)

      directory.path.should == @directory.path
    end

    it 'can get its feature file' do
      feature_file = @background.get_ancestor(:feature_file)

      feature_file.path.should == @directory.feature_files.first.path
    end

    it 'can get its feature' do
      feature = @background.get_ancestor(:feature)

      feature.name.should == @directory.feature_files.first.features.first.name
    end

    it 'returns nil if it does not have the requested type of ancestor' do
      example = @background.get_ancestor(:example)

      example.should be_nil
    end

  end
end
