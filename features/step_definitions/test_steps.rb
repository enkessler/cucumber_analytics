Then /^(?:the )?(?:feature "([^"]*)" )?test(?: "([^"]*)")? is found to have the following properties:$/ do |file, test, properties|
  file ||= 1
  test ||= 1

  properties = properties.rows_hash

  properties.each do |property, value|
    assert value == @parsed_files[file - 1].feature.tests[test - 1].send(property.to_sym).to_s
  end
end

Then /^(?:the )?(?:feature "([^"]*)" )?test(?: "([^"]*)")? descriptive lines are as follows:$/ do |file, test, lines|
  file ||= 1
  test ||= 1
  lines = lines.raw.flatten

  assert @parsed_files[file - 1].feature.tests[test - 1].description == lines
end

Then /^(?:the )?(?:feature "([^"]*)" )?test(?: "([^"]*)")? steps are as follows:$/ do |file, test, steps|
  file ||= 1
  test ||= 1

  steps = steps.raw.flatten.collect do |step|
    if step.start_with? "'"
      step.slice(1..step.length - 2)
    else
      step
    end
  end

  actual_steps = Array.new.tap do |steps|
    @parsed_files[file - 1].feature.tests[test - 1].steps.each do |step|
      steps << step.base
    end
  end

  assert actual_steps.flatten == steps
end

Then /^(?:the )?(?:feature "([^"]*)" )?test(?: "([^"]*)")? is found to have the following tags:$/ do |file, test, tags|
  file ||= 1
  test ||= 1

  expected = tags.raw.flatten
  actual = @parsed_files[file - 1].feature.tests[test - 1].tags

  assert(actual == expected, "Expected: #{expected}\n but was: #{actual}")
end

Then /^(?:the )?(?:feature "([^"]*)" )?test(?: "([^"]*)")? is found to have the following applied tags:$/ do |file, test, tags|
  file ||= 1
  test ||= 1

  expected = tags.raw.flatten
  actual = @parsed_files[file - 1].feature.tests[test - 1].applied_tags

  assert(actual == expected, "Expected: #{expected}\n but was: #{actual}")
end

Then /^(?:the )?(?:feature "([^"]*)" )?test(?: "([^"]*)")? step "([^"]*)" has the following block:$/ do |file, test, step, block|
  file ||= 1
  test ||= 1

  block = block.raw.flatten.collect do |line|
    if line.start_with? "'"
      line.slice(1..line.length - 2)
    else
      line
    end
  end

  assert @parsed_files[file - 1].feature.tests[test - 1].steps[step - 1].block == block
end

Then /^(?:the )?(?:feature "([^"]*)" )?test(?: "([^"]*)")? is equal to test "([^"]*)"$/ do |file, first_test, second_test|
  file ||= 1
  first_test ||= 1

  expected = true
  actual = @parsed_files[file - 1].feature.tests[first_test - 1] == @parsed_files[file - 1].feature.tests[second_test - 1]

  assert(actual == expected, "Expected: #{expected}\n but was: #{actual}")
end

Then /^(?:the )?(?:feature "([^"]*)" )?test(?: "([^"]*)")? is not equal to test "([^"]*)"$/ do |file, first_test, second_test|
  file ||= 1
  first_test ||= 1

  assert @parsed_files[file - 1].feature.tests[first_test - 1] != @parsed_files[file - 1].feature.tests[second_test - 1]
end
