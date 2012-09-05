Given /^the following feature file:$/ do |file_text|
  File.open(@test_file_location, 'w') { |file|
    file.write(file_text)
  }
end

When /^the file is parsed$/ do
  @parsed_file = Cucumber::Analytics::ParsedFile.new(@test_file_location)
end
