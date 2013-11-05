require 'spec_helper'

SimpleCov.command_name('Table') unless RUBY_VERSION.to_s < '1.9.0'

describe 'Table, Integration' do

  it 'properly sets its child elements' do
    source = ['| cell 1 |',
              '| cell 2 |']
    source = source.join("\n")

    table = CucumberAnalytics::Table.new(source)
    row_1 = table.row_elements[0]
    row_2 = table.row_elements[1]

    row_1.parent_element.should equal table
    row_2.parent_element.should equal table
  end

  context 'getting stuff' do

    before(:each) do
      source = ['Feature: Test feature',
                '',
                '  Scenario: Test test',
                '    * a step:',
                '      | a | table |']
      source = source.join("\n")

      file_path = "#{@default_file_directory}/table_row_test_file.feature"
      File.open(file_path, 'w') { |file| file.write(source) }

      @directory = CucumberAnalytics::Directory.new(@default_file_directory)
      @table = @directory.feature_files.first.features.first.tests.first.steps.first.block
    end


    it 'can get its directory' do
      directory = @table.get_ancestor(:directory)

      directory.path.should == @directory.path
    end

    it 'can get its feature file' do
      feature_file = @table.get_ancestor(:feature_file)

      feature_file.path.should == @directory.feature_files.first.path
    end

    it 'can get its feature' do
      feature = @table.get_ancestor(:feature)

      feature.name.should == @directory.feature_files.first.features.first.name
    end

    it 'can get its test' do
      test = @table.get_ancestor(:test)

      test.name.should == @directory.feature_files.first.features.first.tests.first.name
    end

    it 'can get its step' do
      step = @table.get_ancestor(:step)

      step.base.should == @directory.feature_files.first.features.first.tests.first.steps.first.base
    end

    it 'returns nil if it does not have the requested type of ancestor' do
      example = @table.get_ancestor(:example)

      example.should be_nil
    end

  end
end
