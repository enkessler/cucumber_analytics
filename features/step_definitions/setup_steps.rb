Given /^the following feature file:$/ do |file_text|
  File.open(@test_feature_file_location, 'w') { |file|
    file.write(file_text)
  }
end

When /^the file is parsed$/ do
  @parsed_file = Cucumber::Analytics::ParsedFile.new(@test_feature_file_location)
end

Given /^the file "([^"]*)" is parsed$/ do |file_name|
  @parsed_file = Cucumber::Analytics::ParsedFile.new("#{@test_file_directory}/#{file_name}")
end

When /^parameter delimiters of "([^"]*)" and "([^"]*)"$/ do |left_delimiter, right_delimiter|
  @left_delimiter = left_delimiter
  @right_delimiter = right_delimiter
end
