require "#{File.dirname(__FILE__)}/../spec_helper"

SimpleCov.command_name('Step') unless RUBY_VERSION.to_s < '1.9.0'

describe 'Step, Integration' do

  it 'properly sets its child elements' do
    source_1 = ['* a step',
                '"""',
                'a doc string',
                '"""']
    source_2 = ['* a step',
                '| a block|']

    step_1 = CucumberAnalytics::Step.new(source_1.join("\n"))
    step_2 = CucumberAnalytics::Step.new(source_2.join("\n"))


    doc_string = step_1.block
    table = step_2.block

    expect(doc_string.parent_element).to be(step_1)
    expect(table.parent_element).to be(step_2)
  end

  it 'defaults to the World delimiters if its own are not set' do
    world = CucumberAnalytics::World
    world.left_delimiter = '"'
    world.right_delimiter = '"'

    step = CucumberAnalytics::Step.new
    step.right_delimiter = nil
    step.left_delimiter = nil

    expect(step.right_delimiter).to eq('"')
    expect(step.left_delimiter).to eq('"')
  end

  it 'attempts to determine its arguments during creation' do
    source = 'Given a test step with *parameter 1* and "parameter 2" and *parameter 3*'

    world = CucumberAnalytics::World
    world.left_delimiter = '"'
    world.right_delimiter = '"'

    step = CucumberAnalytics::Step.new(source)

    expect(step.arguments).to eq(['parameter 2'])
  end

  it 'finds nothing when no regular expression or delimiters are available' do
    world = CucumberAnalytics::World
    world.left_delimiter = nil
    world.right_delimiter = nil

    source = 'Given a test step with *parameter 1* and "parameter 2" and *parameter 3*'
    step = CucumberAnalytics::Step.new(source)

    step.scan_arguments

    expect(step.arguments).to eq([])
  end

  it 'can determine its equality with another Step' do
    source_1 = "Given a test step with *parameter 1* and *parameter 2*\n|a block|"
    source_2 = "Given a test step with *parameter 3* and *parameter 4*\n|another block|"
    source_3 = 'Given a different *parameterized* step'

    step_1 = CucumberAnalytics::Step.new(source_1)
    step_2 = CucumberAnalytics::Step.new(source_2)
    step_3 = CucumberAnalytics::Step.new(source_3)

    step_1.delimiter = '*'
    step_2.delimiter = '*'
    step_3.delimiter = '*'

    expect(step_1).to eq(step_2)
    expect(step_1).to_not eq(step_3)
  end

  context '#step_text ' do

    before(:each) do
      source = "Given a test step with -parameter 1- ^and@ *parameter 2!!\n|a block|"
      @step = CucumberAnalytics::Step.new(source)
    end


    it 'returns the step\'s entire text by default' do
      source = "Given a test step with -parameter 1- ^and@ *parameter 2!!\n|a block|"
      step_with_block = CucumberAnalytics::Step.new(source)

      expected_output = ['Given a test step with -parameter 1- ^and@ *parameter 2!!',
                         '|a block|']

      expect(step_with_block.step_text).to eq(expected_output)

      source = 'Given a test step with -parameter 1- ^and@ *parameter 2!!'
      step_without_block = CucumberAnalytics::Step.new(source)

      expected_output = ['Given a test step with -parameter 1- ^and@ *parameter 2!!']

      expect(step_without_block.step_text).to eq(expected_output)
    end

    it 'can provide the step\'s text without the keyword' do
      expected_output = ['a test step with -parameter 1- ^and@ *parameter 2!!',
                         '|a block|']

      expect(@step.step_text(:with_keywords => false)).to eq(expected_output)
    end

  end

  context 'getting stuff' do

    before(:each) do
      source = ['Feature: Test feature',
                '',
                '  Scenario: Test test',
                '    * a step:']
      source = source.join("\n")

      file_path = "#{@default_file_directory}/step_test_file.feature"
      File.open(file_path, 'w') { |file| file.write(source) }

      @directory = CucumberAnalytics::Directory.new(@default_file_directory)
      @step = @directory.feature_files.first.features.first.tests.first.steps.first
    end


    it 'can get its directory' do
      directory = @step.get_ancestor(:directory)

      expect(directory).to be(@directory)
    end

    it 'can get its feature file' do
      feature_file = @step.get_ancestor(:feature_file)

      expect(feature_file).to be(@directory.feature_files.first)
    end

    it 'can get its feature' do
      feature = @step.get_ancestor(:feature)

      expect(feature).to be(@directory.feature_files.first.features.first)
    end

    it 'can get its test' do
      test = @step.get_ancestor(:test)

      expect(test).to be(@directory.feature_files.first.features.first.tests.first)
    end

    it 'returns nil if it does not have the requested type of ancestor' do
      example = @step.get_ancestor(:example)

      expect(example).to be_nil
    end

  end

  context 'step output edge cases' do

    before(:each) do
      @step = CucumberAnalytics::Step.new
    end

    it 'can output a step that has only a table' do
      @step.block = CucumberAnalytics::Table.new

      expect { @step.to_s }.to_not raise_error
    end

    it 'can output a step that has only a doc string' do
      @step.block = CucumberAnalytics::DocString.new

      expect { @step.to_s }.to_not raise_error
    end

  end
end
