Then /^scenario "([^"]*)" is found to have the following properties:$/ do |scenario, properties|
  properties = properties.rows_hash

  properties.each do |property, value|
    assert { value == @parsed_file.feature.scenarios[scenario - 1].send(property.to_sym).to_s }
  end
end

Then /^scenario "([^"]*)" descriptive lines are as follows:$/ do |scenario, lines|
  lines = lines.raw.flatten

  assert { @parsed_file.feature.scenarios[scenario - 1].description == lines }
end

Then /^scenario "([^"]*)" steps are as follows:$/ do |scenario, steps|
  steps = steps.raw.flatten

  assert { @parsed_file.feature.scenarios[scenario - 1].steps == steps }
end

Then /^scenario "([^"]*)" is found to have the following tags:$/ do |scenario, tags|
  tags = tags.raw.flatten

  assert { @parsed_file.feature.scenarios[scenario - 1].tags == tags }
end
