require 'spec_helper'

SimpleCov.command_name('Table') unless RUBY_VERSION.to_s < '1.9.0'

describe 'Table, Unit' do

  clazz = CucumberAnalytics::Table

  it_should_behave_like 'a nested element', clazz
  it_should_behave_like 'a bare bones element', clazz
  it_should_behave_like 'a prepopulated element', clazz
  it_should_behave_like 'a raw element', clazz

  it 'can be parsed from stand alone text' do
    source = '| a table |'

    expect { @element = clazz.new(source) }.to_not raise_error

    # Sanity check in case instantiation failed in a non-explosive manner
    expect(@element.row_elements.collect { |row| row.cells }).to eq([['a table']])
    # todo - remove once #contents is no longer supported
    expect(@element.contents).to eq([['a table']])
  end

  before(:each) do
    @table = clazz.new
  end

  # todo - remove once #contents is no longer supported
  it 'has contents - #contents' do
    expect(@table.respond_to?(:contents)).to be true
  end

  # todo - remove once #contents is no longer supported
  it 'can get and set its contents - #contents, #contents=' do
    @table.contents = :some_contents
    expect(@table.contents).to eq(:some_contents)
    @table.contents = :some_other_contents
    expect(@table.contents).to eq(:some_other_contents)
  end

  # todo - remove once #contents is no longer supported
  it 'starts with no contents' do
    expect(@table.contents).to eq([])
  end

  it 'has row elements' do
    expect(@table.respond_to?(:row_elements)).to be true
  end

  it 'can get and set its row elements' do
    @table.row_elements = :some_row_elements
    expect(@table.row_elements).to eq(:some_row_elements)
    @table.row_elements = :some_other_row_elements
    expect(@table.row_elements).to eq(:some_other_row_elements)
  end

  it 'starts with no row elements' do
    expect(@table.row_elements).to eq([])
  end

  # todo - remove once #contents is no longer supported
  it 'stores its contents as a nested array of strings' do
    source = "| cell 1 | cell 2 |\n| cell 3 | cell 4 |"
    table = CucumberAnalytics::Table.new(source)

    contents = table.contents

    expect(contents).to be_a(Array)

    contents.each do |row|
      expect(row).to be_a(Array)
      row.each { |cell| expect(cell).to be_a(String) }
    end
  end

  context 'table output edge cases' do

    it 'is a String' do
      expect(@table.to_s).to be_a(String)
    end

    it 'can output an empty table' do
      expect { @table.to_s }.to_not raise_error
    end

    # todo - remove once #contents is no longer supported
    it 'can output a table that only has contents' do
      @table.contents = ['some contents']

      expect { @table.to_s }.to_not raise_error
    end

  end

end
