Then /^(?:the )?file(?: "([^"]*)")? is found to have the following properties:$/ do |file, properties|
  file ||= 1
  properties = properties.rows_hash

  properties.each do |property, expected_value|
    if property == 'path'
      expected_value.sub!('path_to', @test_directory)
    end

    assert expected_value == @parsed_files[file - 1].send(property.to_sym).to_s
  end
end

When /^(?:the )?file(?: "([^"]*)")? features are as follows:$/ do |file, feature|
  file ||= 1

  assert @parsed_files[file - 1].feature.name == feature.raw.flatten.first
end

When /^(?:the )?file(?: "([^"]*)")? has no features$/ do |file|
  file ||= 1

  assert @parsed_files[file - 1].feature.nil?
end