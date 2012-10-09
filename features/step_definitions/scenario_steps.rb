Then /^(?:feature "([^"]*)" )?scenario "([^"]*)" is found to have the following properties:$/ do |file, scenario, properties|
  file ||= 1
  properties = properties.rows_hash

  properties.each do |property, value|
    assert { value == @parsed_files[file - 1].feature.scenarios[scenario - 1].send(property.to_sym).to_s }
  end
end

Then /^(?:feature "([^"]*)" )?scenario "([^"]*)" descriptive lines are as follows:$/ do |file, scenario, lines|
  file ||= 1
  lines = lines.raw.flatten

  assert { @parsed_files[file - 1].feature.scenarios[scenario - 1].description == lines }
end

Then /^(?:feature "([^"]*)" )?scenario "([^"]*)" steps "([^"]*)" keywords are as follows:$/ do |file, scenario, keywords, steps|
  file ||= 1
  options = keywords == 'with' ? {:with_keywords => true} : {:with_keywords => false}

  steps = steps.raw.flatten.collect do |step|
    if step.start_with? "'"
      step.slice(1..step.length - 2)
    else
      step
    end
  end

  assert { @parsed_files[file - 1].feature.scenarios[scenario - 1].steps(options) == steps }
end

Then /^(?:feature "([^"]*)" )?scenario "([^"]*)" is found to have the following tags:$/ do |file, scenario, tags|
  file ||= 1
  tags = tags.raw.flatten

  assert { @parsed_files[file - 1].feature.scenarios[scenario - 1].tags == tags }
end

Then /^(?:feature "([^"]*)" )?scenario "([^"]*)" stripped steps "([^"]*)" keywords are as follows:$/ do |file, scenario, keywords, steps|
  file ||= 1
  options = keywords == 'with' ? {:with_keywords => true, :with_arguments => false, :left_delimiter => @left_delimiter, :right_delimiter => @right_delimiter} : {:with_keywords => false, :with_arguments => false, :left_delimiter => @left_delimiter, :right_delimiter => @right_delimiter}

  steps = steps.raw.flatten.collect do |step|
    if step.start_with? "'"
      step.slice(1..step.length - 2)
    else
      step
    end
  end

  assert { @parsed_files[file - 1].feature.scenarios[scenario - 1].steps(options) == steps }
end
