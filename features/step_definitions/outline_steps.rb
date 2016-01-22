When /^(?:the )?(?:feature "([^"]*)" )?test(?: "([^"]*)")? example blocks are as follows:$/ do |file, test, names|
  file ||= 1
  test ||= 1

  expected = names.raw.flatten
  actual = @parsed_files[file - 1].feature.tests[test - 1].examples.collect { |example| example.name }

  assert(actual == expected, "Expected: #{expected}\n but was: #{actual}")
end

Then /^(?:the )?(?:feature "([^"]*)" )?test(?: "([^"]*)")? example block(?: "([^"]*)")? is found to have the following properties:$/ do |file, test, example, properties|
  file ||= 1
  test ||= 1
  example ||= 1

  properties = properties.rows_hash

  properties.each do |property, value|
    expect(@parsed_files[file - 1].feature.tests[test - 1].examples[example - 1].send(property.to_sym).to_s).to eq(value)
  end
end

Then /^(?:the )?(?:feature "([^"]*)" )?test(?: "([^"]*)")? example block(?: "([^"]*)")? row(?: "([^"]*)")? is found to have the following properties:$/ do |file, test, example, row, properties|
  file ||= 1
  test ||= 1
  example ||= 1
  row ||= 1

  properties = properties.rows_hash

  properties.each do |property, value|
    expected = value
    actual = @parsed_files[file - 1].feature.tests[test - 1].examples[example - 1].row_elements[row - 1].send(property.to_sym).to_s

    assert(actual == expected, "Expected: #{expected}\n but was: #{actual}")
  end
end

Then /^(?:the )?(?:feature "([^"]*)" )?test(?: "([^"]*)")? example block(?: "([^"]*)")? has the following description:$/ do |file, test, example, text|
  file ||= 1
  test ||= 1
  example ||= 1

  new_description = @parsed_files[file - 1].feature.tests[test - 1].examples[example - 1].description_text
  old_description = @parsed_files[file - 1].feature.tests[test - 1].examples[example - 1].description

  expect(new_description).to eq(text)
  expect(old_description).to eq(remove_whitespace(text))
end

Then /^(?:the )?(?:feature "([^"]*)" )?test(?: "([^"]*)")? example block(?: "([^"]*)")? has no description$/ do |file, test, example|
  file ||= 1
  test ||= 1
  example ||= 1

  new_description = @parsed_files[file - 1].feature.tests[test - 1].examples[example - 1].description_text
  old_description = @parsed_files[file - 1].feature.tests[test - 1].examples[example - 1].description

  expect(new_description).to eq('')
  expect(old_description).to eq([])
end

Then /^(?:the )?(?:feature "([^"]*)" )?test(?: "([^"]*)")? example block(?: "([^"]*)")? is found to have the following tags:$/ do |file, test, example, expected_tags|
  file ||= 1
  test ||= 1
  example ||= 1

  expected_tags = expected_tags.raw.flatten

  expect(@parsed_files[file - 1].feature.tests[test - 1].examples[example - 1].tags).to eq(expected_tags)
  expect(@parsed_files[file - 1].feature.tests[test - 1].examples[example - 1].tag_elements.collect { |tag| tag.name }).to eq(expected_tags)
end

Then /^(?:the )?(?:feature "([^"]*)" )?test(?: "([^"]*)")? example block(?: "([^"]*)")? is found to have the following applied tags:$/ do |file, test, example, expected_tags|
  file ||= 1
  test ||= 1
  example ||= 1

  expected_tags = expected_tags.raw.flatten.sort

  expect(@parsed_files[file - 1].feature.tests[test - 1].examples[example - 1].applied_tags.sort).to eq(expected_tags)
  expect(@parsed_files[file - 1].feature.tests[test - 1].examples[example - 1].applied_tag_elements.collect { |tag| tag.name }.sort).to eq(expected_tags)
end

Then /^(?:the )?(?:feature "([^"]*)" )?test(?: "([^"]*)")? example block(?: "([^"]*)")? has no tags$/ do |file, test, example|
  file ||= 1
  test ||= 1
  example ||= 1

  expect(@parsed_files[file - 1].feature.tests[test - 1].examples[example - 1].tags).to eq([])
  expect(@parsed_files[file - 1].feature.tests[test - 1].examples[example - 1].tag_elements.collect { |tag| tag.name }).to eq([])
end

Then /^(?:the )?(?:feature "([^"]*)" )?test(?: "([^"]*)")? example block(?: "([^"]*)")? rows are as follows:$/ do |file, test, example, rows|
  file ||= 1
  test ||= 1
  example ||= 1

  rows = rows.raw.flatten
  example = @parsed_files[file - 1].feature.tests[test - 1].examples[example - 1]

  expected = rows.collect { |row| row.split(',') }

  actual = example.row_elements[1..example.row_elements.count].collect { |row| row.cells }
  assert(actual == expected, "Expected: #{expected}\n but was: #{actual}")

  # todo - remove once Hash rows are no longer supported
  actual = example.rows.collect { |row| example.parameters.collect { |parameter| row[parameter] } }
  assert(actual == expected, "Expected: #{expected.inspect}\n but was: #{actual.inspect}")
end

When /^(?:the )?(?:feature "([^"]*)" )?test(?: "([^"]*)")? example block(?: "([^"]*)")? has the following rows added to it:$/ do |file, test, example, rows|
  file ||= 1
  test ||= 1
  example ||= 1

  rows = rows.raw.flatten

  rows.each do |row|
    row = row.split(',')
    @parsed_files[file - 1].feature.tests[test - 1].examples[example - 1].add_row(row)
  end
end

When /^(?:the )?(?:feature "([^"]*)" )?test(?: "([^"]*)")? example block(?: "([^"]*)")? has the following rows removed from it:$/ do |file, test, example, rows|
  file ||= 1
  test ||= 1
  example ||= 1

  rows = rows.raw.flatten

  rows.each do |row|
    row = row.split(',')
    @parsed_files[file - 1].feature.tests[test - 1].examples[example - 1].remove_row(row)
  end
end

Then /^(?:the )?(?:feature "([^"]*)" )?test(?: "([^"]*)")? example block(?: "([^"]*)")? parameters are as follows:$/ do |file, test, example, parameters|
  file ||= 1
  test ||= 1
  example ||= 1

  expected = parameters.raw.flatten
  actual = @parsed_files[file - 1].feature.tests[test - 1].examples[example - 1].parameters

  assert(actual == expected, "Expected: #{expected}\n but was: #{actual}")
end

Then /^(?:the )?(?:feature "([^"]*)" )?test(?: "([^"]*)")? example block(?: "([^"]*)")? row(?: "([^"]*)")? cells are as follows:$/ do |file, test, example, row, cells|
  file ||= 1
  test ||= 1
  example ||= 1
  row ||= 1

  expected = cells.raw.flatten
  actual = @parsed_files[file - 1].feature.tests[test - 1].examples[example - 1].row_elements[row - 1].cells

  assert(actual == expected, "Expected: #{expected}\n but was: #{actual}")
end

Then /^(?:the )?(?:feature "([^"]*)" )?test(?: "([^"]*)")? example block(?: "([^"]*)")? has no descriptive lines$/ do |file, test, example|
  file ||= 1
  test ||= 1
  example ||= 1

  assert @parsed_files[file - 1].feature.tests[test - 1].examples[example - 1].description == []
end

Then /^(?:the )?(?:feature "([^"]*)" )?test(?: "([^"]*)")? example block(?: "([^"]*)")? has no parameters$/ do |file, test, example|
  file ||= 1
  test ||= 1
  example ||= 1

  assert @parsed_files[file - 1].feature.tests[test - 1].examples[example - 1].parameters == []
end

Then /^(?:the )?(?:feature "([^"]*)" )?test(?: "([^"]*)")? example block(?: "([^"]*)")? has no rows$/ do |file, test, example|
  file ||= 1
  test ||= 1
  example ||= 1

  example = @parsed_files[file - 1].feature.tests[test - 1].examples[example - 1]

  expect(example.row_elements[1..example.row_elements.count]).to be_empty
  #todo - remove once Hash rows are no longer supported
  expect(example.rows).to be_empty
end

Then /^(?:the )?(?:feature "([^"]*)" )?test(?: "([^"]*)")? example block(?: "([^"]*)")? row(?: "([^"]*)")? correctly stores its underlying implementation$/ do |file, test, example, row|
  file ||= 1
  test ||= 1
  example ||= 1
  row ||= 1

  raw_element = @parsed_files[file - 1].feature.tests[test - 1].examples[example - 1].row_elements[row - 1].raw_element

  expect(raw_element).to have_key('cells')
end

Then /^(?:the )?(?:feature "([^"]*)" )?test(?: "([^"]*)")? example block(?: "([^"]*)")? correctly stores its underlying implementation$/ do |file, test, example|
  file ||= 1
  test ||= 1
  example ||= 1

  raw_element = @parsed_files[file - 1].feature.tests[test - 1].examples[example - 1].raw_element

  expect(raw_element).to have_key('rows')
end

Then(/^the row has convenient output$/) do
  expect(@parsed_files.first.feature.tests.first.examples.first.row_elements.first.method(:to_s).owner).to eq(CucumberAnalytics::Row)
end

Given(/^a row element based on the following gherkin:$/) do |row_text|
  @element = CucumberAnalytics::Row.new(row_text)
end

Given(/^a row element$/) do
  @element = CucumberAnalytics::Row.new
end

When(/^the row element has no cells$/) do
  @element.cells = []
end

Then(/^the example block has convenient output$/) do
  expect(@parsed_files.first.feature.tests.first.examples.first.method(:to_s).owner).to eq(CucumberAnalytics::Example)
end

Given(/^an example element based on the following gherkin:$/) do |example_text|
  @element = CucumberAnalytics::Example.new(example_text)
end

Given(/^an example element$/) do
  @element = CucumberAnalytics::Example.new
end

When(/^the example element has no parameters or rows$/) do
  @element.parameters = []

  #todo - remove once Hash rows are no longer supported
  @element.rows = []
  @element.row_elements = []
end

Then(/^the outline has convenient output$/) do
  expect(@parsed_files.first.feature.tests.first.method(:to_s).owner).to eq(CucumberAnalytics::Outline)
end

Given(/^an outline element based on the following gherkin:$/) do |outline_text|
  @element = CucumberAnalytics::Outline.new(outline_text)
end
