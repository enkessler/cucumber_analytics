Then(/^the following text is provided:$/) do |expected_text|
  expected_text.sub!('path_to', @default_file_directory)

  expect(@output).to eq(expected_text)
end

Then(/^the text provided is "(.*)"$/) do |text_string|
  expect(@output).to eq(text_string.gsub('\n', "\n"))
end
