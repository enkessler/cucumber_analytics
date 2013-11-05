require 'spec_helper'

SimpleCov.command_name('Table') unless RUBY_VERSION.to_s < '1.9.0'

describe 'Table, Integration' do

  it 'properly sets its child elements' do
    source = ['| cell 1 |',
              '| cell 2 |']
    source = source.join("\n")

    table = CucumberAnalytics::Table.new(source)
    row_1 = table.row_elements[0]
    row_2 = table.row_elements[1]

    row_1.parent_element.should equal table
    row_2.parent_element.should equal table
  end

end
