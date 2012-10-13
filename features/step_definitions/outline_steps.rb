Then /^(?:feature "([^"]*)" )?"([^"]*)" example "([^"]*)" has a "([^"]*)"$/ do |file, scenario, example, name|
  file ||= 1

  assert { @parsed_files[file - 1].feature.scenarios[scenario - 1].examples[example - 1].name == name }
end

When /^(?:feature "([^"]*)" )?"([^"]*)" example "([^"]*)" descriptive lines are as follows:$/ do |file, scenario, example, lines|
  file ||= 1
  lines = lines.raw.flatten.delete_if { |line| line == '' }

  assert { @parsed_files[file - 1].feature.scenarios[scenario - 1].examples[example - 1].description == lines }
end

When /^(?:feature "([^"]*)" )?"([^"]*)" example "([^"]*)" tags are as follows:$/ do |file, scenario, example, tags|
  file ||= 1
  tags = tags.raw.flatten.delete_if { |line| line == '' }

  assert { @parsed_files[file - 1].feature.scenarios[scenario - 1].examples[example - 1].tags == tags }
end

When /^(?:feature "([^"]*)" )?"([^"]*)" example "([^"]*)" rows are as follows:$/ do |file, scenario, example, rows|
  file ||= 1
  rows = rows.raw.flatten

  assert { @parsed_files[file - 1].feature.scenarios[scenario - 1].examples[example - 1].rows == rows }
end
