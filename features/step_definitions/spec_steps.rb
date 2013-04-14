Given /^that there are "([^"]*)" detailing models$/ do |spec_file|
  fail "The spec file does not exist: #{spec_file}" unless File.exists?(File.join(SPEC_DIRECTORY, spec_file))

  @spec_file = spec_file
end

When /^the corresponding unit tests are run$/ do
  command = "rspec spec/#{@spec_file}"

  @specs_passed = system(command)
end

Then /^all of those specifications are met$/ do
  fail "There were unmet specifications in '#{@spec_file}'." unless @specs_passed
end
