Then /^(?:the )?(?:feature "([^"]*)" )?(?:test(?: "([^"]*)")? )?(?:step(?: "([^"]*)") )?table has the following contents:$/ do |file, test, step, contents|
  file ||= 1
  test ||= 1
  step ||= 1

  expected = contents.raw
  actual = @parsed_files[file - 1].feature.tests[test - 1].steps[step - 1].block.contents

  assert(actual == expected, "Expected: #{expected}\n but was: #{actual}")
end
