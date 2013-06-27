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

  expected = contents.raw.flatten.collect do |cell_value|
    if cell_value.start_with? "'"
      cell_value.slice(1..cell_value.length - 2)
    else
      cell_value
    end
  end

  actual = @parsed_files[file - 1].feature.tests[test - 1].steps[step - 1].block.contents

  assert(actual == expected, "Expected: #{expected}\n but was: #{actual}")
end

Then /^(?:the )?(?:feature "([^"]*)" )?(?:test(?: "([^"]*)")? )?(?:step(?: "([^"]*)") )?doc string contents are empty$/ do |file, test, step|
  file ||= 1
  test ||= 1
  step ||= 1

  expected = []
  actual = @parsed_files[file - 1].feature.tests[test - 1].steps[step - 1].block.contents

  assert(actual == expected, "Expected: #{expected}\n but was: #{actual}")
end
