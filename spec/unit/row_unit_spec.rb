require 'spec_helper'

SimpleCov.command_name('Row') unless RUBY_VERSION.to_s < '1.9.0'

describe 'Row, Unit' do

  clazz = CucumberAnalytics::Row

  it_should_behave_like 'a nested element', clazz
  it_should_behave_like 'a bare bones element', clazz
  it_should_behave_like 'a prepopulated element', clazz
  it_should_behave_like 'a sourced element', clazz
  it_should_behave_like 'a raw element', clazz

  it 'can be parsed from stand alone text' do
    source = '| a | row |'

    expect { @element = clazz.new(source) }.to_not raise_error

    # Sanity check in case instantiation failed in a non-explosive manner
    @element.cells.should == ['a', 'row']
  end

  before(:each) do
    @table = clazz.new
  end

  it 'has cells - #cells' do
    @table.should respond_to(:cells)
  end

  it 'can get and set its cells - #cells, #cells=' do
    @table.cells = :some_cells
    @table.cells.should == :some_cells
    @table.cells = :some_other_cells
    @table.cells.should == :some_other_cells
  end

  it 'starts with no cells' do
    @table.cells.should == []
  end

end
