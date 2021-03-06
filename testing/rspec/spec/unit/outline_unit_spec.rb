require "#{File.dirname(__FILE__)}/../spec_helper"

SimpleCov.command_name('Outline') unless RUBY_VERSION.to_s < '1.9.0'

describe 'Outline, Unit' do

  clazz = CucumberAnalytics::Outline

  it_should_behave_like 'a feature element', clazz
  it_should_behave_like 'a nested element', clazz
  it_should_behave_like 'a containing element', clazz
  it_should_behave_like 'a tagged element', clazz
  it_should_behave_like 'a bare bones element', clazz
  it_should_behave_like 'a prepopulated element', clazz
  it_should_behave_like 'a test element', clazz
  it_should_behave_like 'a sourced element', clazz
  it_should_behave_like 'a raw element', clazz


  it 'can be parsed from stand alone text' do
    source = 'Scenario Outline: test outline'

    expect { @element = clazz.new(source) }.to_not raise_error

    # Sanity check in case instantiation failed in a non-explosive manner
    expect(@element.name).to eq('test outline')
  end


  before(:each) do
    @outline = clazz.new
  end


  it 'has examples - #examples' do
    expect(@outline.respond_to?(:examples)).to be true
  end

  it 'can get and set its examples - #examples, #examples=' do
    @outline.examples = :some_examples
    expect(@outline.examples).to eq(:some_examples)
    @outline.examples = :some_other_examples
    expect(@outline.examples).to eq(:some_other_examples)
  end

  it 'starts with no examples' do
    expect(@outline.examples).to eq([])
  end

  it 'contains steps and examples' do
    steps = [:step_1, :step_2, :step_3]
    examples = [:example_1, :example_2, :example_3]
    everything = steps + examples

    @outline.steps = steps
    @outline.examples = examples

    expect(@outline.contains).to match_array(everything)
  end

  context 'outline output edge cases' do

    it 'is a String' do
      expect(@outline.to_s).to be_a(String)
    end

    it 'can output an empty outline' do
      expect { @outline.to_s }.to_not raise_error
    end

    it 'can output an outline that has only a name' do
      @outline.name = 'a name'

      expect { @outline.to_s }.to_not raise_error
    end

    it 'can output an outline that has only a description' do
      @outline.description_text = 'a description'

      expect { @outline.to_s }.to_not raise_error
    end

    it 'can output an outline that has only a tags' do
      @outline.tags = ['a tag']

      expect { @outline.to_s }.to_not raise_error
    end

  end

end
