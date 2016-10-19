Then /^(?:the )?(?:feature "([^"]*)" )?(?:test(?: "([^"]*)")? )?(?:step(?: "([^"]*)") )?doc string content type is "([^"]*)"$/ do |file, test, step, type|
  file ||= 1
  test ||= 1
  step ||= 1

  expected = type
  actual = @parsed_files[file - 1].feature.tests[test - 1].steps[step - 1].block.content_type

  assert(actual == expected, "Expected: #{expected}\n but was: #{actual}")
end

Then /^(?:the )?(?:feature "([^"]*)" )?(?:test(?: "([^"]*)")? )?(?:step(?: "([^"]*)") )?doc string has no content type$/ do |file, test, step|
  file ||= 1
  test ||= 1
  step ||= 1

  expected = nil
  actual = @parsed_files[file - 1].feature.tests[test - 1].steps[step - 1].block.content_type

  assert(actual == expected, "Expected: #{expected}\n but was: #{actual}")
end

Then /^(?:the )?(?:feature "([^"]*)" )?(?:test(?: "([^"]*)")? )?(?:step(?: "([^"]*)") )?doc string has the following contents:$/ do |file, test, step, contents|
  file ||= 1
  test ||= 1
  step ||= 1

  expect(@parsed_files[file - 1].feature.tests[test - 1].steps[step - 1].block.contents_text).to eq(contents)
  # Remove once Array contents is no longer supported
  expect(@parsed_files[file - 1].feature.tests[test - 1].steps[step - 1].block.contents).to eq(contents.split("\n", -1))
end

Then /^(?:the )?(?:feature "([^"]*)" )?(?:test(?: "([^"]*)")? )?(?:step(?: "([^"]*)") )?doc string contents are empty$/ do |file, test, step|
  file ||= 1
  test ||= 1
  step ||= 1

  #todo Remove once Array contents is no longer supported
  expect(@parsed_files[file - 1].feature.tests[test - 1].steps[step - 1].block.contents).to be_empty
  expect(@parsed_files[file - 1].feature.tests[test - 1].steps[step - 1].block.contents_text).to be_empty
end

Then(/^(?:the )?(?:feature "([^"]*)" )?(?:test(?: "([^"]*)")? )?(?:step(?: "([^"]*)") )?doc string correctly stores its underlying implementation$/) do |file, test, step|
  file ||= 1
  test ||= 1
  step ||= 1

  raw_element = @parsed_files[file - 1].feature.tests[test - 1].steps[step - 1].block.raw_element

  expect(raw_element).to have_key('content_type')
end

Then(/^the doc string has convenient output$/) do
  expect(@parsed_files.first.feature.tests.first.steps.first.block.method(:to_s).owner).to eq(CucumberAnalytics::DocString)
end

Given(/^a doc string element based on the following gherkin:$/) do |doc_string_text|
  @element = CucumberAnalytics::DocString.new(doc_string_text)
end

Given(/^a doc string element based on the string "(.*)"$/) do |string|
  @element = CucumberAnalytics::DocString.new(string.gsub('\n', "\n"))
end
