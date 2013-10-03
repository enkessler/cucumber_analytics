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
    @element.contents.should == [['a table']]
  end

  before(:each) do
    @table = clazz.new
  end

  it 'has contents - #contents' do
    @table.should respond_to(:contents)
  end

  it 'can get and set its contents - #contents, #contents=' do
    @table.contents = :some_contents
    @table.contents.should == :some_contents
    @table.contents = :some_other_contents
    @table.contents.should == :some_other_contents
  end

  it 'starts with no contents' do
    @table.contents.should == []
  end

  it 'stores its contents as a nested array of strings' do
    source = "| cell 1 | cell 2 |\n| cell 3 | cell 4 |"
    table = CucumberAnalytics::Table.new(source)

    contents = table.contents

    contents.is_a?(Array).should be_true

    contents.each do |row|
      row.is_a?(Array).should be_true
      row.each { |cell| cell.is_a?(String).should be_true }
    end
  end

end
