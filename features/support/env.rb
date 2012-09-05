require File.dirname(__FILE__) + '/../../lib/cucumber-analytics'


TEST_FILE = 'test_file.feature'
TEST_FILE_DIRECTORY = "#{File.dirname(__FILE__)}/../test_files"
TEST_FILE_LOCATION = "#{TEST_FILE_DIRECTORY}/#{TEST_FILE}"

FileUtils.mkdir(TEST_FILE_DIRECTORY)

Before do
  @test_file = TEST_FILE
  @test_file_directory = TEST_FILE_DIRECTORY
  @test_file_location = TEST_FILE_LOCATION

  FileUtils.rm_f(@test_file_location)
end

at_exit do
  FileUtils.remove_dir(TEST_FILE_DIRECTORY, true)
end
