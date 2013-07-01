Then /^the(?: feature "([^"]*)")? background is found to have the following properties:$/ do |file, properties|
  file ||= 1
  properties = properties.rows_hash

  properties.each do |property, expected_value|
    expected = expected_value
    actual = @parsed_files[file - 1].feature.background.send(property.to_sym).to_s

    actual.should == expected
  end
end

Then /^the(?: feature "([^"]*)")? background's descriptive lines are as follows:$/ do |file, lines|
  file ||= 1
  expected_description = lines.raw.flatten
  actual_description = @parsed_files[file - 1].feature.background.description

  actual_description.should == expected_description
end

Then /^the(?: feature "([^"]*)")? background's steps are as follows:$/ do |file, steps|
  file ||= 1

  steps = steps.raw.flatten.collect do |step|
    if step.start_with? "'"
      step.slice(1..step.length - 2)
    else
      step
    end
  end

  actual_steps = Array.new.tap do |steps|
    @parsed_files[file - 1].feature.background.steps.each do |step|
      steps << step.base
    end
  end

  expected = steps
  actual = actual_steps.flatten

  assert(actual == expected, "Expected: #{expected}\n but was: #{actual}")
end

When /^step "([^"]*)" of the background (?:of feature "([^"]*)" )?has the following block:$/ do |step, file, block|
  file ||= 1

  block = block.raw.flatten.collect do |line|
    if line.start_with? "'"
      line.slice(1..line.length - 2)
    else
      line
    end
  end

  assert @parsed_files[file - 1].feature.background.steps[step - 1].block == block
end
