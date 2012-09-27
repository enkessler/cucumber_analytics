Then /^the directory is found to have the following properties:$/ do |properties|
  properties = properties.rows_hash

  properties.each do |property, expected_value|
    puts "checking property: #{property}"
    assert { expected_value == @parsed_directory.send(property.to_sym).to_s }
  end
end
