require 'spec_helper'

SimpleCov.command_name('OutlineExample') unless RUBY_VERSION.to_s < '1.9.0'

describe "OutlineExample" do

  clazz = CucumberAnalytics::OutlineExample

  it_should_behave_like 'a feature element', clazz
  it_should_behave_like 'a nested element', clazz
  it_should_behave_like 'an inheriting element', clazz
  it_should_behave_like 'a tagged element', clazz
  it_should_behave_like 'a bare bones element', clazz

end
