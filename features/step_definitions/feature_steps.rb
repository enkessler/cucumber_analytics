Then /^the feature is found to have the following properties:$/ do |properties|
  properties = properties.rows_hash

  properties.each do |property, expected_value|
    assert { expected_value == @parsed_file.feature.send(property.to_sym).to_s }
  end
end

Then /^the feature's descriptive lines are as follows:$/ do |lines|
  expected_description = lines.raw.flatten

  assert { @parsed_file.feature.description == expected_description }
end

Then /^the feature is found to have the following tags:$/ do |tags|
  expected_tags = tags.raw.flatten

  assert { @parsed_file.feature.tags == expected_tags }
end
