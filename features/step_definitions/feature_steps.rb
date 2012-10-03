Then /^(?:the )?feature(?: "([^"]*)")? is found to have the following properties:$/ do |file, properties|
  file ||= 1
  properties = properties.rows_hash

  properties.each do |property, expected_value|
    assert { expected_value == @parsed_files[file - 1].feature.send(property.to_sym).to_s }
  end
end

Then /^the descriptive lines of feature "([^"]*)" are as follows:$/ do |file, lines|
  expected_description = lines.raw.flatten

  assert { @parsed_files[file - 1].feature.description == expected_description }
end

Then /^feature "([^"]*)" is found to have the following tags:$/ do |file, tags|
  expected_tags = tags.raw.flatten

  assert { @parsed_files[file - 1].feature.tags == expected_tags }
end

Then /^feature "([^"]*)" has no descriptive lines$/ do |file|
  assert { @parsed_files[file - 1].feature.description == [] }
end

Then /^feature "([^"]*)" has no tags$/ do |file|
  assert { @parsed_files[file - 1].feature.tags == [] }
end
