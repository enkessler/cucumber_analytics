require "#{File.dirname(__FILE__)}/../spec_helper"

SimpleCov.command_name('Outline') unless RUBY_VERSION.to_s < '1.9.0'

describe 'Outline, Integration' do

  it 'properly sets its child elements' do
    source = ['@a_tag',
              '  Scenario Outline:',
              '    * a step',
              '  Examples:',
              '    | param |']
    source = source.join("\n")

    outline = CucumberAnalytics::Outline.new(source)
    example = outline.examples.first
    step = outline.steps.first
    tag = outline.tag_elements.first

    expect(example.parent_element).to be(outline)
    expect(step.parent_element).to be(outline)
    expect(tag.parent_element).to be(outline)
  end


  context 'getting stuff' do

    before(:each) do
      source = ['Feature: Test feature',
                '',
                '  Scenario Outline: Test test',
                '    * a step',
                '  Examples: Test example',
                '    | a param |']
      source = source.join("\n")

      file_path = "#{@default_file_directory}/outline_test_file.feature"
      File.open(file_path, 'w') { |file| file.write(source) }

      @directory = CucumberAnalytics::Directory.new(@default_file_directory)
      @outline = @directory.feature_files.first.features.first.tests.first
    end


    it 'can get its directory' do
      directory = @outline.get_ancestor(:directory)

      expect(directory).to be(@directory)
    end

    it 'can get its feature file' do
      feature_file = @outline.get_ancestor(:feature_file)

      expect(feature_file).to be(@directory.feature_files.first)
    end

    it 'can get its feature' do
      feature = @outline.get_ancestor(:feature)

      expect(feature).to be(@directory.feature_files.first.features.first)
    end

    it 'returns nil if it does not have the requested type of ancestor' do
      test = @outline.get_ancestor(:test)

      expect(test).to be_nil
    end

    context 'outline output edge cases' do

      it 'can output an outline that has only a tag elements' do
        @outline.tag_elements = [CucumberAnalytics::Tag.new]

        expect { @outline.to_s }.to_not raise_error
      end

      it 'can output an outline that has only steps' do
        @outline.steps = [CucumberAnalytics::Step.new]

        expect { @outline.to_s }.to_not raise_error
      end

      it 'can output an outline that has only examples' do
        @outline.examples = [CucumberAnalytics::Example.new]

        expect { @outline.to_s }.to_not raise_error
      end

    end

  end
end
