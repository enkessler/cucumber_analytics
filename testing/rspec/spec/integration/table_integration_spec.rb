require "#{File.dirname(__FILE__)}/../spec_helper"

SimpleCov.command_name('Table') unless RUBY_VERSION.to_s < '1.9.0'

describe 'Table, Integration' do

  it 'properly sets its child elements' do
    source = ['| cell 1 |',
              '| cell 2 |']
    source = source.join("\n")

    table = CucumberAnalytics::Table.new(source)
    row_1 = table.row_elements[0]
    row_2 = table.row_elements[1]

    expect(row_1.parent_element).to be(table)
    expect(row_2.parent_element).to be(table)
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

      expect(directory).to be(@directory)
    end

    it 'can get its feature file' do
      feature_file = @table.get_ancestor(:feature_file)

      expect(feature_file).to be(@directory.feature_files.first)
    end

    it 'can get its feature' do
      feature = @table.get_ancestor(:feature)

      expect(feature).to be(@directory.feature_files.first.features.first)
    end

    it 'can get its test' do
      test = @table.get_ancestor(:test)

      expect(test).to be(@directory.feature_files.first.features.first.tests.first)
    end

    it 'can get its step' do
      step = @table.get_ancestor(:step)

      expect(step).to be(@directory.feature_files.first.features.first.tests.first.steps.first)
    end

    it 'returns nil if it does not have the requested type of ancestor' do
      example = @table.get_ancestor(:example)

      expect(example).to be_nil
    end

  end

  context 'table output edge cases' do
    # todo - remove once #contents is no longer supported
    it 'can output a table that only has row elements' do
      table = CucumberAnalytics::Table.new
      table.row_elements = [CucumberAnalytics::TableRow.new]

      expect { table.to_s }.to_not raise_error
    end

  end
end
