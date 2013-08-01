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
    assert value == @parsed_files[file - 1].feature.tests[test - 1].examples[example - 1].send(property.to_sym).to_s
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


  expected = tags.raw.flatten
  actual = @parsed_files[file - 1].feature.tests[test - 1].examples[example - 1].tags

  assert(actual == expected, "Expected: #{expected}\n but was: #{actual}")
end

Then /^(?:the )?(?:feature "([^"]*)" )?test(?: "([^"]*)")? example block(?: "([^"]*)")? is found to have the following applied tags:$/ do |file, test, example, tags|
  file ||= 1
  test ||= 1
  example ||= 1

  tags = tags.raw.flatten

  expected = tags.sort
  actual = @parsed_files[file - 1].feature.tests[test - 1].examples[example - 1].applied_tags.sort

  assert(actual == expected, "Expected: #{expected}\n but was: #{actual}")
end

Then /^(?:the )?(?:feature "([^"]*)" )?test(?: "([^"]*)")? example block(?: "([^"]*)")? has no tags$/ do |file, test, example|
  file ||= 1
  test ||= 1
  example ||= 1

  expected = []
  actual = @parsed_files[file - 1].feature.tests[test - 1].examples[example - 1].tags

  assert(actual == expected, "Expected: #{expected}\n but was: #{actual}")
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

  expected = []
  actual = example.row_elements[1..example.row_elements.count]

  assert(actual == expected, "Expected: #{expected}\n but was: #{actual}")
end
