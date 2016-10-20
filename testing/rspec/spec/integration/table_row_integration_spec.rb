require "#{File.dirname(__FILE__)}/../spec_helper"

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

      expect(directory).to be(@directory)
    end

    it 'can get its feature file' do
      feature_file = @table_row.get_ancestor(:feature_file)

      expect(feature_file).to be(@directory.feature_files.first)
    end

    it 'can get its feature' do
      feature = @table_row.get_ancestor(:feature)

      expect(feature).to be(@directory.feature_files.first.features.first)
    end

    it 'can get its test' do
      test = @table_row.get_ancestor(:test)

      expect(test).to be(@directory.feature_files.first.features.first.tests.first)
    end

    it 'can get its step' do
      step = @table_row.get_ancestor(:step)

      expect(step).to be(@directory.feature_files.first.features.first.tests.first.steps.first)
    end

    it 'can get its table' do
      table = @table_row.get_ancestor(:table)

      expect(table).to be(@directory.feature_files.first.features.first.tests.first.steps.first.block)
    end

    it 'returns nil if it does not have the requested type of ancestor' do
      example = @table_row.get_ancestor(:example)

      expect(example).to be_nil
    end

  end
end
