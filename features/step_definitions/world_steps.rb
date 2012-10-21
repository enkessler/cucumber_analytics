Then /^the tags collected from (?:feature "([^"]*)" )?test "([^"]*)" are as follows:$/ do |file, test, tags|
  file ||= 1
  tags = tags.raw.flatten

  assert { Cucumber::Analytics::World.tags_in(@parsed_files[file - 1].feature.tests[test - 1]).sort == tags.sort }
end

Then /^the tags collected from feature "([^"]*)" are as follows:$/ do |file, tags|
  file ||= 1
  tags = tags.raw.flatten

  assert { Cucumber::Analytics::World.tags_in(@parsed_files[file - 1].feature).sort == tags.sort }
end

Then /^the tags collected from file "([^"]*)" are as follows:$/ do |file, tags|
  file ||= 1
  tags = tags.raw.flatten

  assert { Cucumber::Analytics::World.tags_in(@parsed_files[file - 1]).sort == tags.sort }
end

Then /^the tags collected from directory are as follows:$/ do |tags|
  tags = tags.raw.flatten

  assert { Cucumber::Analytics::World.tags_in(@parsed_directories.last).sort == tags.sort }
end

Then /^the(?: "([^"]*)")? steps collected from feature "([^"]*)" background are as follows:$/ do |defined, file, steps|
  file ||= 1
  steps = steps.raw.flatten
  container = @parsed_files[file - 1].feature.background

  case defined
    when 'defined'
      expected_steps = Cucumber::Analytics::World.defined_steps_in(container)
    when 'undefined'
      expected_steps = Cucumber::Analytics::World.undefined_steps_in(container)
    else
      expected_steps = Cucumber::Analytics::World.steps_in(container)
  end

  assert { expected_steps.collect { |step| step.step_text }.flatten.sort == steps.sort }
end

Then /^the(?: "([^"]*)")? steps collected from feature "([^"]*)" test "([^"]*)" are as follows:$/ do |defined, file, test, steps|
  file ||= 1
  steps = steps.raw.flatten
  container = @parsed_files[file - 1].feature.tests[test - 1]

  case defined
    when 'defined'
      expected_steps = Cucumber::Analytics::World.defined_steps_in(container)
    when 'undefined'
      expected_steps = Cucumber::Analytics::World.undefined_steps_in(container)
    else
      expected_steps = Cucumber::Analytics::World.steps_in(container)
  end

  assert { expected_steps.collect { |step| step.step_text }.flatten.sort == steps.sort }
end

When /^the(?: "([^"]*)")? steps collected from (?:the )?feature(?: "([^"]*)")? are as follows:$/ do |defined, file, steps|
  file ||= 1
  steps = steps.raw.flatten
  container = @parsed_files[file - 1].feature

  case defined
    when 'defined'
      expected_steps = Cucumber::Analytics::World.defined_steps_in(container)
    when 'undefined'
      expected_steps = Cucumber::Analytics::World.undefined_steps_in(container)
    else
      expected_steps = Cucumber::Analytics::World.steps_in(container)
  end

  assert { expected_steps.collect { |step| step.step_text }.flatten.sort == steps.sort }
end

When /^the(?: "([^"]*)")? steps collected from (?:the )?file(?: "([^"]*)")? are as follows:$/ do |defined, file, steps|
  file ||= 1
  steps = steps.raw.flatten
  container = @parsed_files[file - 1]

  case defined
    when 'defined'
      expected_steps = Cucumber::Analytics::World.defined_steps_in(container)
    when 'undefined'
      expected_steps = Cucumber::Analytics::World.undefined_steps_in(container)
    else
      expected_steps = Cucumber::Analytics::World.steps_in(container)
  end

  assert { expected_steps.collect { |step| step.step_text }.flatten.sort == steps.sort }
end

When /^the(?: "([^"]*)")? steps collected from the directory are as follows:$/ do |defined, steps|
  steps = steps.raw.flatten
  container = @parsed_directories.last

  case defined
    when 'defined'
      expected_steps = Cucumber::Analytics::World.defined_steps_in(container)
    when 'undefined'
      expected_steps = Cucumber::Analytics::World.undefined_steps_in(container)
    else
      expected_steps = Cucumber::Analytics::World.steps_in(container)
  end

  assert { expected_steps.collect { |step| step.step_text }.flatten.sort == steps.sort }
end

Then /^the tests collected from feature "([^"]*)" are as follows:$/ do |file, tests|
  file ||= 1

  actual_tests = Cucumber::Analytics::World.tests_in(@parsed_files[file - 1].feature).collect { |test| test.name }

  assert { actual_tests.flatten.sort == tests.raw.flatten.sort }
end

Then /^the tests collected from file "([^"]*)" are as follows:$/ do |file, tests|
  file ||= 1

  actual_tests = Cucumber::Analytics::World.tests_in(@parsed_files[file - 1]).collect { |test| test.name }

  assert { actual_tests.flatten.sort == tests.raw.flatten.sort }
end

Then /^the tests collected from directory "([^"]*)" are as follows:$/ do |directory, tests|
  directory ||= 1

  actual_tests = Cucumber::Analytics::World.tests_in(@parsed_directories[directory - 1]).collect { |test| test.name }

  assert { actual_tests.flatten.sort == tests.raw.flatten.sort }
end

Then /^the features collected from file "([^"]*)" are as follows:$/ do |file, features|
  file ||= 1

  actual_features = Cucumber::Analytics::World.features_in(@parsed_files[file - 1]).collect { |feature| feature.name }

  assert { actual_features.flatten.sort == features.raw.flatten.sort }
end

Then /^the features collected from directory "([^"]*)" are as follows:$/ do |directory, features|
  directory ||= 1

  actual_features = Cucumber::Analytics::World.features_in(@parsed_directories[directory - 1]).collect { |feature| feature.name }

  assert { actual_features.flatten.sort == features.raw.flatten.sort }
end

Then /^the files collected from directory "([^"]*)" are as follows:$/ do |directory, files|
  directory ||= 1

  actual_files = Cucumber::Analytics::World.files_in(@parsed_directories[directory - 1]).collect { |file| file.name }

  assert { actual_files.flatten.sort == files.raw.flatten.sort }
end
