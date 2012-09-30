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

Then /^scenario "([^"]*)" steps "([^"]*)" keywords are as follows:$/ do |scenario, keywords, steps|
  steps = steps.raw.flatten.collect do |step|
    if step.start_with? "'"
      step.slice(1..step.length - 2)
    else
      step
    end
  end

  assert { @parsed_file.feature.scenarios[scenario - 1].steps(keywords == 'with' ? true : false) == steps }
end

Then /^scenario "([^"]*)" is found to have the following tags:$/ do |scenario, tags|
  tags = tags.raw.flatten

  assert { @parsed_file.feature.scenarios[scenario - 1].tags == tags }
end

Then /^scenario "([^"]*)" stripped steps "([^"]*)" keywords are as follows:$/ do |scenario, keywords, steps|
  steps = steps.raw.flatten.collect do |step|
    if step.start_with? "'"
      step.slice(1..step.length - 2)
    else
      step
    end
  end

  assert { @parsed_file.feature.scenarios[scenario - 1].stripped_steps(@left_delimiter, @right_delimiter, keywords == 'with' ? true : false) == steps }
end
