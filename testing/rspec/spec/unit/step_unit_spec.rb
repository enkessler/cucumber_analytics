require 'spec_helper'

SimpleCov.command_name('Step') unless RUBY_VERSION.to_s < '1.9.0'

describe 'Step, Unit' do

  clazz = CucumberAnalytics::Step

  it_should_behave_like 'a nested element', clazz
  it_should_behave_like 'a bare bones element', clazz
  it_should_behave_like 'a prepopulated element', clazz
  it_should_behave_like 'a sourced element', clazz
  it_should_behave_like 'a raw element', clazz

  before(:each) do
    @step = clazz.new
  end

  it 'has arguments - #arguments' do
    expect(@step.respond_to?(:arguments)).to be true
  end

  it 'can get and set its arguments - #arguments, #arguments=' do
    @step.arguments = :some_arguments
    expect(@step.arguments).to eq(:some_arguments)
    @step.arguments = :some_other_arguments
    expect(@step.arguments).to eq(:some_other_arguments)
  end

  it 'starts with no arguments' do
    expect(@step.arguments).to eq([])
  end

  it 'has a base - #base' do
    expect(@step.respond_to?(:base)).to be true
  end

  it 'can get and set its base - #base, #base=' do
    @step.base = :some_base
    expect(@step.base).to eq(:some_base)
    @step.base = :some_other_base
    expect(@step.base).to eq(:some_other_base)
  end

  it 'starts with no base' do
    expect(@step.base).to be_nil
  end

  it 'has a block - #block' do
    expect(@step.respond_to?(:block)).to be true
  end

  it 'can get and set its block - #block, #block=' do
    @step.block = :some_block
    expect(@step.block).to eq(:some_block)
    @step.block = :some_other_block
    expect(@step.block).to eq(:some_other_block)
  end

  it 'starts with no block' do
    expect(@step.block).to be_nil
  end

  it 'has a keyword - #keyword' do
    expect(@step.respond_to?(:keyword)).to be true
  end

  it 'can get and set its keyword - #keyword, #keyword=' do
    @step.keyword = :some_keyword
    expect(@step.keyword).to eq(:some_keyword)
    @step.keyword = :some_other_keyword
    expect(@step.keyword).to eq(:some_other_keyword)
  end

  it 'starts with no keyword' do
    expect(@step.keyword).to be_nil
  end

  it 'has a left delimiter - #left_delimiter' do
    expect(@step.respond_to?(:left_delimiter)).to be true
  end

  it 'can get and set its left delimiter - #left_delimiter, #left_delimiter=' do
    @step.left_delimiter = :some_left_delimiter
    expect(@step.left_delimiter).to eq(:some_left_delimiter)
    @step.left_delimiter = :some_other_left_delimiter
    expect(@step.left_delimiter).to eq(:some_other_left_delimiter)
  end

  it 'starts with no left delimiter' do
    expect(@step.left_delimiter).to be_nil
  end

  it 'has a right delimiter - #right_delimiter' do
    expect(@step.respond_to?(:right_delimiter)).to be true
  end

  it 'can get and set its right delimiter - #right_delimiter, #right_delimiter=' do
    @step.right_delimiter = :some_right_delimiter
    expect(@step.right_delimiter).to eq(:some_right_delimiter)
    @step.right_delimiter = :some_other_right_delimiter
    expect(@step.right_delimiter).to eq(:some_other_right_delimiter)
  end

  it 'starts with no right delimiter' do
    expect(@step.right_delimiter).to be_nil
  end

  it 'can set both of its delimiters at once - #delimiter=' do
    @step.delimiter = :new_delimiter
    expect(@step.left_delimiter).to eq(:new_delimiter)
    expect(@step.right_delimiter).to eq(:new_delimiter)
  end

  context '#scan_arguments' do

    it 'can explicitly scan for arguments' do
      expect(@step.respond_to?(:scan_arguments)).to be true
    end

    it 'can determine its arguments based on a regular expression' do
      source = 'Given a test step with a parameter'
      step = CucumberAnalytics::Step.new(source)

      step.scan_arguments(/parameter/)
      expect(step.arguments).to eq(['parameter'])
      step.scan_arguments(/t s/)
      expect(step.arguments).to eq(['t s'])
    end

    it 'can determine its arguments based on delimiters' do
      source = 'Given a test step with -parameter 1- and -parameter 2-'

      step = CucumberAnalytics::Step.new(source)

      step.scan_arguments('-', '-')
      expect(step.arguments).to eq(['parameter 1', 'parameter 2'])
      step.scan_arguments('!', '!')
      expect(step.arguments).to eq([])
    end

    it 'can use different left and right delimiters when scanning' do
      source = 'Given a test step with !a parameter-'

      step = CucumberAnalytics::Step.new(source)

      step.scan_arguments('!', '-')
      expect(step.arguments).to eq(['a parameter'])
    end

    it 'can use delimiters of varying lengths' do
      source = 'Given a test step with -start-a parameter-end-'

      step = CucumberAnalytics::Step.new(source)

      step.scan_arguments('-start-', '-end-')
      expect(step.arguments).to eq(['a parameter'])
    end

    it 'can handle delimiters with special regular expression characters' do
      source = 'Given a test step with \d+a parameter.?'

      step = CucumberAnalytics::Step.new(source)

      step.scan_arguments('\d+', '.?')
      expect(step.arguments).to eq(['a parameter'])
    end

    it 'defaults to its set delimiters when scanning' do
      source = 'Given a test step with *parameter 1* and "parameter 2" and *parameter 3*'
      step = CucumberAnalytics::Step.new(source)

      step.left_delimiter = '"'
      step.right_delimiter = '"'
      step.scan_arguments

      expect(step.arguments).to eq(['parameter 2'])
    end
  end

  it 'can be parsed from stand alone text' do
    source = '* test step'

    expect { @element = clazz.new(source) }.to_not raise_error

    # Sanity check in case instantiation failed in a non-explosive manner
    expect(@element.base).to eq('test step')
  end

  context '#step_text' do

    before(:each) do
      source = "Given a test step with -parameter 1- ^and@ *parameter 2!!\n|a block|"
      @step = CucumberAnalytics::Step.new(source)
      @step.delimiter = '-'
    end

    it 'can provide different flavors of step\'s text' do
      expect(@step.respond_to?(:step_text)).to be true
    end

    it 'returns different text based on options' do
      expect(clazz.instance_method(:step_text).arity != 0).to be true
    end

    it 'returns the step\'s text as an Array' do
      expect(@step.step_text).to be_a(Array)
    end

    it 'can provide the step\'s text without the arguments' do
      expected_output = ['Given a test step with -- ^and@ *parameter 2!!']

      expect(@step.step_text(:with_arguments => false)).to eq(expected_output)
    end

    it 'can determine its arguments based on delimiters' do
      expected_output = ['Given a test step with -parameter 1- ^@ *parameter 2!!']

      expect(@step.step_text(:with_arguments => false, :left_delimiter => '^', :right_delimiter => '@')).to eq(expected_output)
    end

    it 'can use delimiters of varying lengths' do
      expected_output = ['Given a test step with -parameter 1- ^and@ *!!']

      expect(@step.step_text(:with_arguments => false, :left_delimiter => '*', :right_delimiter => '!!')).to eq(expected_output)
    end

    it 'can handle delimiters with special regular expression characters' do
      expected_output = ['Given a test step with -parameter 1- ^and@ *!!']

      expect(@step.step_text(:with_arguments => false, :left_delimiter => '*', :right_delimiter => '!!')).to eq(expected_output)
    end

  end

  context 'step output edge cases' do

    it 'is a String' do
      expect(@step.to_s).to be_a(String)
    end

    it 'can output an empty step' do
      expect { @step.to_s }.to_not raise_error
    end

    it 'can output a step that has only a keyword' do
      @step.keyword = '*'

      expect { @step.to_s }.to_not raise_error
    end

    it 'can output a step that has only a base' do
      @step.base = 'step base'

      expect { @step.to_s }.to_not raise_error
    end

  end

  it 'can gracefully be compared to other types of objects' do
    # Some common types of object
    [1, 'foo', :bar, [], {}].each do |thing|
      expect { @step == thing }.to_not raise_error
      expect(@step == thing).to be false
    end
  end

end
