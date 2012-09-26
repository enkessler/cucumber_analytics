Then /^the background is found to have the following properties:$/ do |properties|
  properties = properties.rows_hash

  properties.each do |property, expected_value|
    assert { expected_value == @parsed_file.feature.background.send(property.to_sym).to_s }
  end
end

Then /^the background's descriptive lines are as follows:$/ do |lines|
  expected_description = lines.raw.flatten

  assert { @parsed_file.feature.background.description == expected_description }
end

Then /^the background's steps are as follows:$/ do |steps|
  steps = steps.raw.flatten.collect do |step|
    if step.start_with? "'"
      step.slice(1..step.length - 2)
    else
      step
    end
  end

  assert { @parsed_file.feature.background.steps == steps }
end

Then /^the background's stripped steps are as follows:$/ do |steps|
  steps = steps.raw.flatten.collect do |step|
    if step.start_with? "'"
      step.slice(1..step.length - 2)
    else
      step
    end
  end

  assert { @parsed_file.feature.background.stripped_steps(@left_delimiter, @right_delimiter, @keywords_included) == steps }
end
