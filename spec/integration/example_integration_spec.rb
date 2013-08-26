require 'spec_helper'

SimpleCov.command_name('Example') unless RUBY_VERSION.to_s < '1.9.0'

describe 'Example, Integration' do

  it 'properly sets its child elements' do
    source = ['@a_tag',
              'Examples:',
              '  | param   |',
              '  | value 1 |']
    source = source.join("\n")

    example = CucumberAnalytics::Example.new(source)
    rows = example.row_elements
    tag = example.tag_elements.first

    rows[0].parent_element.should equal example
    rows[1].parent_element.should equal example
    tag.parent_element.should equal example
  end

end
