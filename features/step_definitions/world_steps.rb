When /^the step definitions are loaded$/ do
  Cucumber::Analytics::World.load_step_file(@test_step_file_location)
end

Then /^the tags collected from (?:feature "([^"]*)" )?scenario "([^"]*)" are as follows:$/ do |file, scenario, tags|
  file ||= 1
  tags = tags.raw.flatten

  assert { Cucumber::Analytics::World.tags_in(@parsed_files[file - 1].feature.scenarios[scenario - 1]).sort == tags.sort }
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

  assert { expected_steps.collect { |step| step.text_step }.flatten.sort == steps.sort }
end

Then /^the(?: "([^"]*)")? steps collected from feature "([^"]*)" scenario "([^"]*)" are as follows:$/ do |defined, file, scenario, steps|
  file ||= 1
  steps = steps.raw.flatten
  container = @parsed_files[file - 1].feature.scenarios[scenario - 1]

  case defined
    when 'defined'
      expected_steps = Cucumber::Analytics::World.defined_steps_in(container)
    when 'undefined'
      expected_steps = Cucumber::Analytics::World.undefined_steps_in(container)
    else
      expected_steps = Cucumber::Analytics::World.steps_in(container)
  end

  assert { expected_steps.collect { |step| step.text_step }.flatten.sort == steps.sort }
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

  assert { expected_steps.collect { |step| step.text_step }.flatten.sort == steps.sort }
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

  assert { expected_steps.collect { |step| step.text_step }.flatten.sort == steps.sort }
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

  assert { expected_steps.collect { |step| step.text_step }.flatten.sort == steps.sort }
end
