Then /^(?:the )?(?:feature "([^"]*)" )?(?:scenario|outline)(?: "([^"]*)")? is found to have the following properties:$/ do |file, scenario, properties|
  file ||= 1
  scenario ||= 1

  properties = properties.rows_hash

  properties.each do |property, value|
    assert { value == @parsed_files[file - 1].feature.scenarios[scenario - 1].send(property.to_sym).to_s }
  end
end

Then /^(?:the )?(?:feature "([^"]*)" )?(?:scenario|outline)(?: "([^"]*)")? descriptive lines are as follows:$/ do |file, scenario, lines|
  file ||= 1
  scenario ||= 1
  lines = lines.raw.flatten

  assert { @parsed_files[file - 1].feature.scenarios[scenario - 1].description == lines }
end

Then /^(?:the )?(?:feature "([^"]*)" )?(?:scenario|outline)(?: "([^"]*)")? steps(?: "([^"]*)" arguments)?(?: "([^"]*)" keywords)? are as follows:$/ do |file, scenario, arguments, keywords, steps|
  file ||= 1
  scenario ||= 1
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
    @parsed_files[file - 1].feature.scenarios[scenario - 1].steps.each do |step|
      steps << step.step_text(options)
    end
  end

  assert { actual_steps.flatten == steps }
end

Then /^(?:the )?(?:feature "([^"]*)" )?(?:scenario|outline)(?: "([^"]*)")? is found to have the following tags:$/ do |file, scenario, tags|
  file ||= 1
  scenario ||= 1

  assert { @parsed_files[file - 1].feature.scenarios[scenario - 1].tags == tags.raw.flatten }
end

Then /^(?:the )?(?:feature "([^"]*)" )?(?:scenario|outline)(?: "([^"]*)")? step "([^"]*)" has the following block:$/ do |file, scenario, step, block|
  file ||= 1
  scenario ||= 1

  block = block.raw.flatten.collect do |line|
    if line.start_with? "'"
      line.slice(1..line.length - 2)
    else
      line
    end
  end

  assert { @parsed_files[file - 1].feature.scenarios[scenario - 1].steps[step - 1].block == block }
end
