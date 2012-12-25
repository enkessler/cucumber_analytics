When /^(?:the )?(?:feature "([^"]*)" )?test(?: "([^"]*)")? example blocks are as follows:$/ do |file, test, names|
  file ||= 1
  test ||= 1

  names = names.raw.flatten

  assert @parsed_files[file - 1].feature.tests[test - 1].examples.collect { |example| example.name } == names
end

Then /^(?:the )?(?:feature "([^"]*)" )?test(?: "([^"]*)")? example block(?: "([^"]*)")? is found to have the following properties:$/ do |file, test, example, properties|
  file ||= 1
  test ||= 1
  example ||= 1

  properties = properties.rows_hash

  properties.each do |property, value|
    assert value == @parsed_files[file - 1].feature.tests[test - 1].examples[example - 1].send(property.to_sym).to_s
  end
end

Then /^(?:the )?(?:feature "([^"]*)" )?test(?: "([^"]*)")? example block(?: "([^"]*)")? descriptive lines are as follows:$/ do |file, test, example, lines|
  file ||= 1
  test ||= 1
  example ||= 1

  lines = lines.raw.flatten

  assert @parsed_files[file - 1].feature.tests[test - 1].examples[example - 1].description == lines
end

Then /^(?:the )?(?:feature "([^"]*)" )?test(?: "([^"]*)")? example block(?: "([^"]*)")? is found to have the following tags:$/ do |file, test, example, tags|
  file ||= 1
  test ||= 1
  example ||= 1

  tags = tags.raw.flatten

  assert @parsed_files[file - 1].feature.tests[test - 1].examples[example - 1].tags == tags
end

Then /^(?:the )?(?:feature "([^"]*)" )?test(?: "([^"]*)")? example block(?: "([^"]*)")? has no tags$/ do |file, test, example|
  file ||= 1
  test ||= 1
  example ||= 1

  assert @parsed_files[file - 1].feature.tests[test - 1].examples[example - 1].tags == []
end

Then /^(?:the )?(?:feature "([^"]*)" )?test(?: "([^"]*)")? example block(?: "([^"]*)")? rows are as follows:$/ do |file, test, example, rows|
  file ||= 1
  test ||= 1
  example ||= 1

  rows = rows.raw.flatten

  assert @parsed_files[file - 1].feature.tests[test - 1].examples[example - 1].rows == rows
end
