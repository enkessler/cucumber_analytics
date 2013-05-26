require 'spec_helper'

SimpleCov.command_name('Example') unless RUBY_VERSION.to_s < '1.9.0'

describe "Example" do

  clazz = CucumberAnalytics::Example

  it_should_behave_like 'a feature element', clazz
  it_should_behave_like 'a nested element', clazz
  it_should_behave_like 'a tagged element', clazz
  it_should_behave_like 'a bare bones element', clazz

  it 'can be parsed from stand alone text' do
    source = ['Examples: ',
              '|param| ']

    source = source.join("\n")

    expect { clazz.new(source) }.to_not raise_error
  end

end
