When /^the step definitions are loaded$/ do
  Cucumber::Analytics::World.load_step_file(@test_step_file_location)
end

Then /^the tags collected from (?:feature "([^"]*)" )?scenario "([^"]*)" are as follows:$/ do |file, scenario, tags|
  file ||= 1
  tags = tags.raw.flatten

  assert { Cucumber::Analytics::World.tags_in(@parsed_files[file - 1].feature.scenarios[scenario - 1]) == tags }
end

Then /^the tags collected from feature "([^"]*)" are as follows:$/ do |file, tags|
  file ||= 1
  tags = tags.raw.flatten

  assert { Cucumber::Analytics::World.tags_in(@parsed_files[file - 1].feature) == tags }
end

Then /^the tags collected from file "([^"]*)" are as follows:$/ do |file, tags|
  file ||= 1
  tags = tags.raw.flatten

  assert { Cucumber::Analytics::World.tags_in(@parsed_files[file - 1]) == tags }
end

Then /^the tags collected from directory are as follows:$/ do |tags|
  tags = tags.raw.flatten

  assert { Cucumber::Analytics::World.tags_in(@parsed_directory) == tags }
end
