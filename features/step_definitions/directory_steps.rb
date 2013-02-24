Then /^(?:the )?directory(?: "([^"]*)")? is found to have the following properties:$/ do |directory, properties|
  directory ||= 1
  properties = properties.rows_hash

  properties.each do |property, expected_value|
    if property == 'path'
      expected_value.sub!('path_to', @default_file_directory)
    end

    assert expected_value == @parsed_directories[directory - 1].send(property.to_sym).to_s
  end
end

When /^(?:the )?directory(?: "([^"]*)")? feature files are as follows:$/ do |directory, files|
  directory ||= 1

  actual_files = @parsed_directories[directory - 1].feature_files.collect { |file| file.name }

  assert actual_files.flatten.sort == files.raw.flatten.sort
end

When /^(?:the )?directory(?: "([^"]*)")? directories are as follows:$/ do |directory, directories|
  directory ||= 1

  expected = directories.raw.flatten.sort
  actual = @parsed_directories[directory - 1].feature_directories.collect { |sub_directory| sub_directory.name }

  assert(actual == expected, "Expected: #{expected}\n but was: #{actual}")
end

When /^(?:the )?directory(?: "([^"]*)")? has no directories$/ do |directory|
  directory ||= 1

  expected = []
  actual = @parsed_directories[directory - 1].feature_directories

  assert(actual == expected, "Expected: #{expected}\n but was: #{actual}")
end
