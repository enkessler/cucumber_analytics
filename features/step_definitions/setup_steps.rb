Given /^the following(?: feature)? file(?: "([^"]*)")?:$/ do |file_name, file_text|
  @test_directory ||= @temp_file_directory
  file_name ||= @test_feature_file_name

  File.open("#{@test_directory}/#{file_name}", 'w') { |file|
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

Given /^a directory "([^"]*)"$/ do |directory_name|
  @test_directory = "#{@temp_file_directory}/#{directory_name}"

  FileUtils.mkdir(@test_directory)
end

When /^the directory(?: "([^"]*)")? is read$/ do |directory_name|
  @test_directory = "#{@temp_file_directory}/#{directory_name}" if directory_name

  @parsed_directory = Cucumber::Analytics::ParsedDirectory.new(@test_directory)
end
