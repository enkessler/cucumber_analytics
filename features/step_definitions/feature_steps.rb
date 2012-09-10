Then /^the feature is found to have the following properties:$/ do |properties|
  properties = properties.rows_hash

  properties.each do |property, expected_value|
    assert { expected_value == @parsed_file.feature.send(property.to_sym).to_s }
  end
end

Then /^the feature's descriptive lines are as follows:$/ do |table|
  pending
end

Then /^the feature is found to have the following tags:$/ do |table|
  pending
end
