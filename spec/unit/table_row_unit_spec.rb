require 'spec_helper'

SimpleCov.command_name('TableRow') unless RUBY_VERSION.to_s < '1.9.0'

describe 'TableRow, Unit' do

  clazz = CucumberAnalytics::TableRow

  it_should_behave_like 'a nested element', clazz
  it_should_behave_like 'a bare bones element', clazz
  it_should_behave_like 'a prepopulated element', clazz
  it_should_behave_like 'a sourced element', clazz
  it_should_behave_like 'a raw element', clazz

  it 'can be parsed from stand alone text' do
    source = '| a | row |'

    expect { @element = clazz.new(source) }.to_not raise_error

    # Sanity check in case instantiation failed in a non-explosive manner
    expect(@element.cells).to eq(['a', 'row'])
  end

  before(:each) do
    @row = clazz.new
  end

  it 'has cells' do
    expect(@row.respond_to?(:cells)).to be true
  end

  it 'can get and set its cells' do
    @row.cells = :some_cells
    expect(@row.cells).to eq(:some_cells)
    @row.cells = :some_other_cells
    expect(@row.cells).to eq(:some_other_cells)
  end

  it 'starts with no cells' do
    expect(@row.cells).to eq([])
  end

  context 'table row output edge cases' do

    it 'is a String' do
      expect(@row.to_s).to be_a(String)
    end

    it 'can output an empty table row' do
      expect { @row.to_s }.to_not raise_error
    end

  end

end
