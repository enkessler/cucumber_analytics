require 'spec_helper'

SimpleCov.command_name('ParsedBackground') unless RUBY_VERSION.to_s < '1.9.0'

describe "ParsedBackground" do

  it 'properly sets its child elements' do
    source = ['  Background: Test background',
              '    * a step']
    source = source.join("\n")

    background = CucumberAnalytics::ParsedBackground.new(source)
    step = background.steps.first

    step.parent_element.should equal background
  end

end
