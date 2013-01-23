Then /^(?:the )?directory(?: "([^"]*)")? is found to have the following properties:$/ do |directory, properties|
  directory ||= 1
  properties = properties.rows_hash

  properties.each do |property, expected_value|
    if property == 'path'
      expected_value.sub!('path_to', @default_file_directory)
    end

    expected = expected_value
    actual = @parsed_directories[directory - 1].send(property.to_sym).to_s

    assert(actual == expected, "Expected: #{expected}\n but was: #{actual}")
  end
end

When /^(?:the )?directory(?: "([^"]*)")? feature files are as follows:$/ do |directory, files|
  directory ||= 1

  actual_files = @parsed_directories[directory - 1].feature_files.collect { |file| file.name }

  assert actual_files.flatten.sort == files.raw.flatten.sort
end
