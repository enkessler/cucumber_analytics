Then /^"([^"]*)" example "([^"]*)" has a "([^"]*)"$/ do |scenario, example, name|
  assert { @parsed_file.feature.scenarios[scenario - 1].examples[example - 1].name == name }
end

When /^"([^"]*)" example "([^"]*)" descriptive lines are as follows:$/ do |scenario, example, lines|
  lines = lines.raw.flatten.delete_if { |line| line == '' }

  assert { @parsed_file.feature.scenarios[scenario - 1].examples[example - 1].description == lines }
end

When /^"([^"]*)" example "([^"]*)" tags are as follows:$/ do |scenario, example, tags|
  tags = tags.raw.flatten.delete_if { |line| line == '' }

  assert { @parsed_file.feature.scenarios[scenario - 1].examples[example - 1].tags == tags }
end

When /^"([^"]*)" example "([^"]*)" rows are as follows:$/ do |scenario, example, rows|
  rows = rows.raw.flatten

  assert { @parsed_file.feature.scenarios[scenario - 1].examples[example - 1].rows == rows }
end
