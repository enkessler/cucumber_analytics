When /^the step definitions are loaded$/ do
  Cucumber::Analytics::World.load_step_file(@test_step_file_location)
end
