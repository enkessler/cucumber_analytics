require 'spec_helper'

SimpleCov.command_name('Scenario') unless RUBY_VERSION.to_s < '1.9.0'

describe 'Scenario, Integration' do

  it 'properly sets its child elements' do
    source = ['@a_tag',
              'Scenario: Test scenario',
              '  * a step']
    source = source.join("\n")

    scenario = CucumberAnalytics::Scenario.new(source)
    step = scenario.steps.first
    tag = scenario.tag_elements.first

    expect(step.parent_element).to be(scenario)
    expect(tag.parent_element).to be(scenario)
  end


  context 'getting stuff' do

    before(:each) do
      source = ['Feature: Test feature',
                '',
                '  Scenario: Test test',
                '    * a step']
      source = source.join("\n")

      file_path = "#{@default_file_directory}/scenario_test_file.feature"
      File.open(file_path, 'w') { |file| file.write(source) }

      @directory = CucumberAnalytics::Directory.new(@default_file_directory)
      @scenario = @directory.feature_files.first.features.first.tests.first
    end


    it 'can get its directory' do
      directory = @scenario.get_ancestor(:directory)

      expect(directory).to be(@directory)
    end

    it 'can get its feature file' do
      feature_file = @scenario.get_ancestor(:feature_file)

      expect(feature_file).to be(@directory.feature_files.first)
    end

    it 'can get its feature' do
      feature = @scenario.get_ancestor(:feature)

      expect(feature).to be(@directory.feature_files.first.features.first)
    end

    it 'returns nil if it does not have the requested type of ancestor' do
      test = @scenario.get_ancestor(:test)

      expect(test).to be_nil
    end

    context 'scenario output edge cases' do

      it 'can output a scenario that has only a tag elements' do
        @scenario.tag_elements = [CucumberAnalytics::Tag.new]

        expect { @scenario.to_s }.to_not raise_error
      end

      it 'can output a scenario that has only steps' do
        @scenario.steps = [CucumberAnalytics::Step.new]

        expect { @scenario.to_s }.to_not raise_error
      end

    end

  end
end
