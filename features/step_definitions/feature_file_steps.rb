Then /^(?:the )?file(?: "([^"]*)")? is found to have the following properties:$/ do |file, properties|
  file ||= 1
  properties = properties.rows_hash

  properties.each do |property, expected_value|
    if property == 'path'
      expected_value.sub!('path_to', @test_directory)
    end

    expected = expected_value
    actual = @parsed_files[file - 1].send(property.to_sym).to_s

    assert(actual == expected, "Expected: #{expected}\n but was: #{actual}")
  end
end

When /^(?:the )?file(?: "([^"]*)")? features are as follows:$/ do |file, feature|
  file ||= 1

  expected = feature.raw.flatten.first
  actual = @parsed_files[file - 1].feature.name

  assert(actual == expected, "Expected: #{expected}\n but was: #{actual}")
end

When /^(?:the )?file(?: "([^"]*)")? has no features$/ do |file|
  file ||= 1

  assert @parsed_files[file - 1].feature.nil?
end