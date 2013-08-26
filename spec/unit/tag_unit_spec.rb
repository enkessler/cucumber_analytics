require 'spec_helper'

SimpleCov.command_name('Tag') unless RUBY_VERSION.to_s < '1.9.0'

describe 'Tag, Unit' do

  clazz = CucumberAnalytics::Tag

  it_should_behave_like 'a nested element', clazz
  it_should_behave_like 'a bare bones element', clazz
  it_should_behave_like 'a prepopulated element', clazz
  it_should_behave_like 'a sourced element', clazz
  it_should_behave_like 'a raw element', clazz


  it 'can be parsed from stand alone text' do
    source = '@a_tag'

    expect { @element = clazz.new(source) }.to_not raise_error
    @element.name.should == '@a_tag'
  end

  before(:each) do
    @element = clazz.new
  end


  it 'has a name' do
    @element.should respond_to(:name)
  end

  it 'can get and set its name' do
    @element.name = :some_name
    @element.name.should == :some_name
    @element.name = :some_other_name
    @element.name.should == :some_other_name
  end

end
