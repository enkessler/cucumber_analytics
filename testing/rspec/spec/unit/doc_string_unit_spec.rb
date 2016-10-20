require "#{File.dirname(__FILE__)}/../spec_helper"

SimpleCov.command_name('DocString') unless RUBY_VERSION.to_s < '1.9.0'

describe 'DocString, Unit' do

  clazz = CucumberAnalytics::DocString

  it_should_behave_like 'a nested element', clazz
  it_should_behave_like 'a bare bones element', clazz
  it_should_behave_like 'a prepopulated element', clazz
  it_should_behave_like 'a raw element', clazz

  it 'can be parsed from stand alone text' do
    source = "\"\"\"\nsome doc string\n\"\"\""

    expect { @element = clazz.new(source) }.to_not raise_error

    # Sanity check in case instantiation failed in a non-explosive manner
    expect(@element.contents_text).to eq("some doc string")
    #todo Remove once Array contents is no longer supported
    expect(@element.contents).to eq(["some doc string"])
  end

  before(:each) do
    @doc_string = clazz.new
  end

  it 'has a content type - #content_type' do
    expect(@doc_string.respond_to?(:content_type)).to be true
  end

  it 'can get and set its content type - #content_type, #content_type=' do
    @doc_string.content_type = :some_content_type
    expect(@doc_string.content_type).to eq(:some_content_type)
    @doc_string.content_type = :some_other_content_type
    expect(@doc_string.content_type).to eq(:some_other_content_type)
  end

  it 'starts with no content type' do
    expect(@doc_string.content_type).to be_nil
  end

  it 'has contents' do
    #todo Remove once Array contents is no longer supported
    expect(@doc_string.respond_to?(:contents)).to be true
    expect(@doc_string.respond_to?(:contents_text)).to be true
  end

  it 'can get and set its contents' do
    #todo Remove once Array contents is no longer supported
    @doc_string.contents = :some_contents
    expect(@doc_string.contents).to eq(:some_contents)
    @doc_string.contents = :some_other_contents
    expect(@doc_string.contents).to eq(:some_other_contents)

    @doc_string.contents_text = :some_contents
    expect(@doc_string.contents_text).to eq(:some_contents)
    @doc_string.contents_text = :some_other_contents
    expect(@doc_string.contents_text).to eq(:some_other_contents)
  end

  it 'starts with no contents' do
    #todo Remove once Array contents is no longer supported
    expect(@doc_string.contents).to eq([])
    expect(@doc_string.contents_text).to eq('')
  end

  #todo Remove once Array contents is no longer supported
  it 'stores its contents as an array of strings - deprecated' do
    source = "\"\"\"\nsome text\nsome more text\n\"\"\""
    doc_string = CucumberAnalytics::DocString.new(source)

    contents = doc_string.contents

    expect(contents).to be_a(Array)
    contents.each do |line|
      expect(line).to be_a(String)
    end
  end

  it 'stores its contents as a String' do
    source = "\"\"\"\nsome text\nsome more text\n\"\"\""
    doc_string = clazz.new(source)

    contents = doc_string.contents_text

    expect(contents).to be_a(String)
  end

  context 'doc string output edge cases' do

    it 'is a String' do
      expect(@doc_string.to_s).to be_a(String)
    end

    it 'can output an empty doc string' do
      expect { @doc_string.to_s }.to_not raise_error
    end

    it 'can output a doc string that has only a content type' do
      @doc_string.content_type = 'some type'

      expect { @doc_string.to_s }.to_not raise_error
    end

  end

end
