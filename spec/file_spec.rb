require 'spec_helper'

SimpleCov.command_name('ParsedFile') unless RUBY_VERSION.to_s < '1.9.0'

describe "ParsedFile" do

  clazz = CucumberAnalytics::ParsedFile

  it_should_behave_like 'a nested element', clazz
  it_should_behave_like 'a containing element', clazz
  it_should_behave_like 'a bare bones element', clazz

end
