Then /^the(?: feature "([^"]*)")? background is found to have the following properties:$/ do |file, properties|
  file ||= 1
  properties = properties.rows_hash

  properties.each do |property, expected_value|
    assert { expected_value == @parsed_files[file - 1].feature.background.send(property.to_sym).to_s }
  end
end

Then /^the(?: feature "([^"]*)")? background's descriptive lines are as follows:$/ do |file, lines|
  file ||= 1
  expected_description = lines.raw.flatten

  assert { @parsed_files[file - 1].feature.background.description == expected_description }
end

Then /^the(?: feature "([^"]*)")? background's steps "([^"]*)" keywords are as follows:$/ do |file, keywords, steps|
  file ||= 1
  options = keywords == 'with' ? {:with_keywords => true} : {:with_keywords => false}

  steps = steps.raw.flatten.collect do |step|
    if step.start_with? "'"
      step.slice(1..step.length - 2)
    else
      step
    end
  end

  assert { @parsed_files[file - 1].feature.background.steps(options) == steps }
end

Then /^the(?: feature "([^"]*)")? background's stripped steps "([^"]*)" keywords are as follows:$/ do |file, keywords, steps|
  file ||= 1
  options = keywords == 'with' ? {:with_keywords => true, :with_arguments => false, :left_delimiter => @left_delimiter, :right_delimiter => @right_delimiter} : {:with_keywords => false, :with_arguments => false, :left_delimiter => @left_delimiter, :right_delimiter => @right_delimiter}

  steps = steps.raw.flatten.collect do |step|
    if step.start_with? "'"
      step.slice(1..step.length - 2)
    else
      step
    end
  end

  assert { @parsed_files[file - 1].feature.background.steps(options) == steps }
end
