Then /^(?:the )?(?:feature "([^"]*)" )?(?:test(?: "([^"]*)")? )?(?:step(?: "([^"]*)") )?table has the following contents:$/ do |file, test, step, contents|
  file ||= 1
  test ||= 1
  step ||= 1

  expected = contents.raw

  expect(@parsed_files[file - 1].feature.tests[test - 1].steps[step - 1].block.row_elements.collect { |row| row.cells }).to eq(expected)
  # todo - remove once #contents is no longer supported
  expect(@parsed_files[file - 1].feature.tests[test - 1].steps[step - 1].block.contents).to eq(expected)
end

Then /^(?:the )?(?:feature "([^"]*)" )?(?:test(?: "([^"]*)")? )?(?:step(?: "([^"]*)") )?table correctly stores its underlying implementation$/ do |file, test, step|
  file ||= 1
  test ||= 1
  step ||= 1

  raw_element = @parsed_files[file - 1].feature.tests[test - 1].steps[step - 1].block.raw_element

  expect(raw_element).to be_a(Array)
  raw_element.each { |row| expect(row).to have_key('cells') }
end

Given(/^a table row element$/) do
  @element = CucumberAnalytics::TableRow.new
end

When(/^the table row element has no cells$/) do
  @element.cells = []
end

Given(/^a table row element based on the following gherkin:$/) do |row_text|
  @element = CucumberAnalytics::TableRow.new(row_text)
end

Then(/^the table row has convenient output$/) do
  expect(@parsed_files.first.feature.tests.first.steps.first.block.row_elements.first.method(:to_s).owner).to eq(CucumberAnalytics::TableRow)
end

Given(/^a table element$/) do
  @element = CucumberAnalytics::Table.new
end

When(/^the table element has no rows$/) do
  @element.row_elements = []
end

Then(/^the table has convenient output$/) do
  expect(@parsed_files.first.feature.tests.first.steps.first.block.method(:to_s).owner).to eq(CucumberAnalytics::Table)
end

Given(/^a table element based on the following gherkin:$/) do |table_text|
  @element = CucumberAnalytics::Table.new(table_text)
end
