require 'spec_helper'

SimpleCov.command_name('ParsedOutline') unless RUBY_VERSION.to_s < '1.9.0'

describe "ParsedOutline" do

  clazz = CucumberAnalytics::ParsedScenarioOutline

  it_should_behave_like 'a feature element', clazz
  it_should_behave_like 'a nested element', clazz
  it_should_behave_like 'an inheriting element', clazz
  it_should_behave_like 'a containing element', clazz
  it_should_behave_like 'a tagged element', clazz
  it_should_behave_like 'a bare bones element', clazz
  it_should_behave_like 'a test element', clazz

end
