require File.dirname(__FILE__) + '/../../lib/cucumber-analytics'

Bundler.require

include Wrong

TEST_FEATURE_FILE = 'test_feature.feature'
TEMP_FILE_DIRECTORY = "#{File.dirname(__FILE__)}/../temp_files"
TEST_FILE_DIRECTORY = "#{File.dirname(__FILE__)}/../test_files"
TEST_FEATURE_FILE_LOCATION = "#{TEMP_FILE_DIRECTORY}/#{TEST_FEATURE_FILE}"

FileUtils.mkdir(TEMP_FILE_DIRECTORY)

Before do
  @test_file_directory = TEST_FILE_DIRECTORY
  @test_feature_file_location = TEST_FEATURE_FILE_LOCATION

  FileUtils.rm_f(@test_feature_file_location)
end

at_exit do
  FileUtils.remove_dir(TEMP_FILE_DIRECTORY, true)
end
