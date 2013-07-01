require 'spec_helper'

SimpleCov.command_name('Example') unless RUBY_VERSION.to_s < '1.9.0'

describe 'Example, Unit' do

  clazz = CucumberAnalytics::Example

  it_should_behave_like 'a feature element', clazz
  it_should_behave_like 'a nested element', clazz
  it_should_behave_like 'a tagged element', clazz
  it_should_behave_like 'a bare bones element', clazz
  it_should_behave_like 'a prepopulated element', clazz


  it 'can be parsed from stand alone text' do
    source = ['Examples: ',
              '|param| ']

    source = source.join("\n")

    expect { clazz.new(source) }.to_not raise_error
  end


  before(:each) do
    @example = clazz.new
  end


  it 'has parameters - #parameters' do
    @example.should respond_to(:parameters)
  end

  it 'can get and set its parameters - #parameters, #parameters=' do
    @example.parameters = :some_parameters
    @example.parameters.should == :some_parameters
    @example.parameters = :some_other_parameters
    @example.parameters.should == :some_other_parameters
  end

  it 'starts with no parameters' do
    @example.parameters.should == []
  end

  it 'has rows - #rows' do
    @example.should respond_to(:rows)
  end

  it 'can get and set its rows - #rows, #rows=' do
    @example.rows = :some_rows
    @example.rows.should == :some_rows
    @example.rows = :some_other_rows
    @example.rows.should == :some_other_rows
  end

  it 'starts with no rows' do
    @example.rows.should == []
  end

  it 'stores its rows as an nested array of hashes' do
    source = "Examples:\n|param1|param2|\n|value1|value2|"
    example = CucumberAnalytics::Example.new(source)

    rows = example.rows

    rows.is_a?(Array).should be_true
    rows.empty?.should be_false
    rows.each { |row| row.is_a?(Hash).should be_true }
  end

  it 'does not include the parameter row as a row' do
    source = "Examples:\n|param1|param2|\n|value1|value2|\n|value3|value4|"
    example = CucumberAnalytics::Example.new(source)

    rows = example.rows

    rows.collect { |row| row.values }.should == [['value1', 'value2'], ['value3', 'value4']]
  end

  context '#add_row' do

    it 'can add a new example row' do
      clazz.new.should respond_to(:add_row)
    end

    it 'can add a new row as a hash' do
      source = "Examples:\n|param1|param2|\n|value1|value2|"
      example = CucumberAnalytics::Example.new(source)

      new_row = {'param1' => 'value3', 'param2' => 'value4'}
      example.add_row(new_row)

      example.rows.collect { |row| row.values }.should == [['value1', 'value2'], ['value3', 'value4']]
    end

    it 'can add a new row as an array' do
      source = "Examples:\n|param1|param2|\n|value1|value2|"
      example = CucumberAnalytics::Example.new(source)

      new_row = ['value3', 'value4']
      example.add_row(new_row)

      example.rows.collect { |row| row.values }.should == [['value1', 'value2'], ['value3', 'value4']]
    end

    it 'can only use a Hash or an Array to add a new row' do
      expect { @example.add_row({}) }.to_not raise_error
      expect { @example.add_row([]) }.to_not raise_error
      expect { @example.add_row(:a_row) }.to raise_error(ArgumentError)
    end

    it 'trims whitespace from added rows' do
      source = "Examples:\n|param1|param2|\n|value1|value2|"
      example = CucumberAnalytics::Example.new(source)

      hash_row = {'param1' => 'value3  ', 'param2' => '  value4'}
      array_row = ['value5', ' value6 ']
      example.add_row(hash_row)
      example.add_row(array_row)

      example.rows.collect { |row| row.values }.should == [['value1', 'value2'], ['value3', 'value4'], ['value5', 'value6']]
    end
  end

  context '#remove_row' do

    it 'can remove an existing example row' do
      clazz.new.should respond_to(:remove_row)
    end

    it 'can remove an existing row as a hash' do
      source = "Examples:\n|param1|param2|\n|value1|value2|\n|value3|value4|"
      example = CucumberAnalytics::Example.new(source)

      old_row = {'param1' => 'value3', 'param2' => 'value4'}
      example.remove_row(old_row)

      example.rows.collect { |row| row.values }.should == [['value1', 'value2']]
    end

    it 'can remove an existing row as an array' do
      source = "Examples:\n|param1|param2|\n|value1|value2|\n|value3|value4|"
      example = CucumberAnalytics::Example.new(source)

      old_row = ['value3', 'value4']
      example.remove_row(old_row)

      example.rows.collect { |row| row.values }.should == [['value1', 'value2']]
    end

    it 'can only use a Hash or an Array to remove an existing row' do
      expect { @example.remove_row({}) }.to_not raise_error
      expect { @example.remove_row([]) }.to_not raise_error
      expect { @example.remove_row(:a_row) }.to raise_error(ArgumentError)
    end

    it 'trims whitespace from removed rows' do
      source = "Examples:\n|param1|param2|\n|value1|value2|\n|value3|value4|\n|value5|value6|"
      example = CucumberAnalytics::Example.new(source)

      hash_row = {'param1' => 'value3  ', 'param2' => '  value4'}
      array_row = ['value5', ' value6 ']
      example.remove_row(hash_row)
      example.remove_row(array_row)

      example.rows.collect { |row| row.values }.should == [['value1', 'value2']]
    end
  end

end
