require 'spec_helper'

SimpleCov.command_name('TableRow') unless RUBY_VERSION.to_s < '1.9.0'

describe 'TableRow, Integration' do

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
      @table_row = @directory.feature_files.first.features.first.tests.first.steps.first.block.row_elements.first
    end


    it 'can get its directory' do
      directory = @table_row.get_ancestor(:directory)

      directory.path.should == @directory.path
    end

    it 'can get its feature file' do
      feature_file = @table_row.get_ancestor(:feature_file)

      feature_file.path.should == @directory.feature_files.first.path
    end

    it 'can get its feature' do
      feature = @table_row.get_ancestor(:feature)

      feature.name.should == @directory.feature_files.first.features.first.name
    end

    it 'can get its test' do
      test = @table_row.get_ancestor(:test)

      test.name.should == @directory.feature_files.first.features.first.tests.first.name
    end

    it 'can get its step' do
      step = @table_row.get_ancestor(:step)

      step.should == @directory.feature_files.first.features.first.tests.first.steps.first
    end

    it 'can get its table' do
      table = @table_row.get_ancestor(:table)

      table.should == @directory.feature_files.first.features.first.tests.first.steps.first.block
    end

    it 'returns nil if it does not have the requested type of ancestor' do
      example = @table_row.get_ancestor(:example)

      example.should be_nil
    end

  end
end
