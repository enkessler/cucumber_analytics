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

Then /^the(?: feature "([^"]*)")? background's steps(?: "([^"]*)" arguments)?(?: "([^"]*)" keywords)? are as follows:$/ do |file, arguments, keywords, steps|
  file ||= 1
  arguments ||= 'with'
  keywords ||= 'with'
  translate = {'with' => true,
               'without' => false}

  options = {:with_keywords => translate[keywords], :with_arguments => translate[arguments], :left_delimiter => @left_delimiter, :right_delimiter => @right_delimiter}

  steps = steps.raw.flatten.collect do |step|
    if step.start_with? "'"
      step.slice(1..step.length - 2)
    else
      step
    end
  end

  actual_steps = Array.new.tap do |steps|
    @parsed_files[file - 1].feature.background.steps.each do |step|
      steps << step.step_text(options)
    end
  end

  assert { actual_steps.flatten == steps }
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

  assert { @parsed_files[file - 1].feature.background.steps[step - 1].block == block }
end
