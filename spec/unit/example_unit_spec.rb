require 'spec_helper'

SimpleCov.command_name('Example') unless RUBY_VERSION.to_s < '1.9.0'

describe 'Example, Unit' do

  clazz = CucumberAnalytics::Example

  it_should_behave_like 'a feature element', clazz
  it_should_behave_like 'a nested element', clazz
  it_should_behave_like 'a tagged element', clazz
  it_should_behave_like 'a bare bones element', clazz
  it_should_behave_like 'a prepopulated element', clazz
  it_should_behave_like 'a sourced element', clazz
  it_should_behave_like 'a containing element', clazz
  it_should_behave_like 'a raw element', clazz


  it 'can be parsed from stand alone text' do
    source = ['Examples: test example',
              '|param| ']

    source = source.join("\n")

    expect { @element = clazz.new(source) }.to_not raise_error

    # Sanity check in case instantiation failed in a non-explosive manner
    expect(@element.name).to eq('test example')
  end


  before(:each) do
    @example = clazz.new
  end


  it 'has parameters - #parameters' do
    expect(@example.respond_to?(:parameters)).to be true
  end

  it 'can get and set its parameters - #parameters, #parameters=' do
    @example.parameters = :some_parameters
    expect(@example.parameters).to eq(:some_parameters)
    @example.parameters = :some_other_parameters
    expect(@example.parameters).to eq(:some_other_parameters)
  end

  it 'starts with no parameters' do
    expect(@example.parameters).to eq([])
  end

  it 'has rows - #rows' do
    expect(@example.respond_to?(:rows)).to be true
  end

  #todo - remove once Hash rows are no longer supported
  it 'can get and set its rows - #rows, #rows=' do
    @example.rows = :some_rows
    expect(@example.rows).to eq(:some_rows)
    @example.rows = :some_other_rows
    expect(@example.rows).to eq(:some_other_rows)
  end

  #todo - remove once Hash rows are no longer supported
  it 'starts with no rows' do
    expect(@example.rows).to eq([])
  end

  #todo - remove once Hash rows are no longer supported
  it 'stores its rows as an nested array of hashes' do
    source = "Examples:\n|param1|param2|\n|value1|value2|"
    example = CucumberAnalytics::Example.new(source)

    rows = example.rows

    expect(rows).to be_a(Array)
    expect(rows.empty?).to be false
    rows.each { |row| expect(row).to be_a(Hash) }
  end

  it 'does not include the parameter row as a row' do
    source = "Examples:\n|param1|param2|\n|value1|value2|\n|value3|value4|"
    example = CucumberAnalytics::Example.new(source)

    rows = example.rows

    expect(rows).to eq([{'param1' => 'value1', 'param2' => 'value2'}, {'param1' => 'value3', 'param2' => 'value4'}])
  end

  it 'has row elements - #row_elements' do
    expect(@example.respond_to?(:row_elements)).to be true
  end

  it 'can get and set its row elements - #row_elements, #row_elements=' do
    @example.row_elements = :some_row_elements
    expect(@example.row_elements).to eq(:some_row_elements)
    @example.row_elements = :some_other_row_elements
    expect(@example.row_elements).to eq(:some_other_row_elements)
  end

  it 'starts with no row elements' do
    expect(@example.row_elements).to eq([])
  end

  context '#add_row' do

    it 'can add a new example row' do
      expect(clazz.new.respond_to?(:add_row)).to be true
    end

    it 'can add a new row as a hash' do
      source = "Examples:\n|param1|param2|\n|value1|value2|"
      example = CucumberAnalytics::Example.new(source)

      new_row = {'param1' => 'value3', 'param2' => 'value4'}
      example.add_row(new_row)

      #todo - remove once Hash rows are no longer supported
      expect(example.rows).to eq([{'param1' => 'value1', 'param2' => 'value2'}, {'param1' => 'value3', 'param2' => 'value4'}])
      expect(example.row_elements.collect { |row| row.cells }[1..example.row_elements.count]).to eq([['value1', 'value2'], ['value3', 'value4']])
    end

    it 'can add a new row as an array' do
      source = "Examples:\n|param1|param2|\n|value1|value2|"
      example = CucumberAnalytics::Example.new(source)

      new_row = ['value3', 'value4']
      example.add_row(new_row)

      #todo - remove once Hash rows are no longer supported
      expect(example.rows).to eq([{'param1' => 'value1', 'param2' => 'value2'}, {'param1' => 'value3', 'param2' => 'value4'}])
      expect(example.row_elements.collect { |row| row.cells }[1..example.row_elements.count]).to eq([['value1', 'value2'], ['value3', 'value4']])
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

      #todo - remove once Hash rows are no longer supported
      expect(example.rows).to eq([{'param1' => 'value1', 'param2' => 'value2'}, {'param1' => 'value3', 'param2' => 'value4'}, {'param1' => 'value5', 'param2' => 'value6'}])
      expect(example.row_elements.collect { |row| row.cells }[1..example.row_elements.count]).to eq([['value1', 'value2'], ['value3', 'value4'], ['value5', 'value6']])
    end
  end

  context '#remove_row' do

    it 'can remove an existing example row' do
      expect(clazz.new.respond_to?(:remove_row)).to be true
    end

    it 'can remove an existing row as a hash' do
      source = "Examples:\n|param1|param2|\n|value1|value2|\n|value3|value4|"
      example = CucumberAnalytics::Example.new(source)

      old_row = {'param1' => 'value3', 'param2' => 'value4'}
      example.remove_row(old_row)

      #todo - remove once Hash rows are no longer supported
      expect(example.rows).to eq([{'param1' => 'value1', 'param2' => 'value2'}])
      expect(example.row_elements.collect { |row| row.cells }[1..example.row_elements.count]).to eq([['value1', 'value2']])
    end

    it 'can remove an existing row as an array' do
      source = "Examples:\n|param1|param2|\n|value1|value2|\n|value3|value4|"
      example = CucumberAnalytics::Example.new(source)

      old_row = ['value3', 'value4']
      example.remove_row(old_row)

      #todo - remove once Hash rows are no longer supported
      expect(example.rows).to eq([{'param1' => 'value1', 'param2' => 'value2'}])
      expect(example.row_elements.collect { |row| row.cells }[1..example.row_elements.count]).to eq([['value1', 'value2']])
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

      #todo - remove once Hash rows are no longer supported
      expect(example.rows).to eq([{'param1' => 'value1', 'param2' => 'value2'}])
      expect(example.row_elements.collect { |row| row.cells }[1..example.row_elements.count]).to eq([['value1', 'value2']])
    end
  end

  context 'example output edge cases' do

    it 'is a String' do
      expect(@example.to_s).to be_a(String)
    end

    it 'can output an empty example' do
      expect { @example.to_s }.to_not raise_error
    end

    it 'can output an example that has only a name' do
      @example.name = 'a name'

      expect { @example.to_s }.to_not raise_error
    end

    it 'can output an example that has only a description' do
      @example.description_text = 'a description'

      expect { @example.to_s }.to_not raise_error
    end

    it 'can output an example that has only a tags' do
      @example.tags = ['a tag']

      expect { @example.to_s }.to_not raise_error
    end

    #todo - remove once Hash rows are no longer supported
    it 'can output an example that only has parameters' do
      @example.parameters = ['param1']

      expect { @example.to_s }.to_not raise_error
    end

    #todo - remove once Hash rows are no longer supported
    it 'can output an example that only has rows' do
      @example.rows = [{:param1 => 'row1'}]

      expect { @example.to_s }.to_not raise_error
    end

  end

end
