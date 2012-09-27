require File.dirname(__FILE__) + '/../../lib/cucumber-analytics'

Bundler.require

include Wrong

TEST_FEATURE_FILE_NAME = 'test_feature.feature'
TEMP_FILE_DIRECTORY = "#{File.dirname(__FILE__)}/../temp_files"
TEST_FILE_DIRECTORY = "#{File.dirname(__FILE__)}/../test_files"
TEST_FEATURE_FILE_LOCATION = "#{TEMP_FILE_DIRECTORY}/#{TEST_FEATURE_FILE_NAME}"


Before do
  @test_feature_file_name = TEST_FEATURE_FILE_NAME
  @test_file_directory = TEST_FILE_DIRECTORY
  @temp_file_directory = TEMP_FILE_DIRECTORY
  @test_feature_file_location = TEST_FEATURE_FILE_LOCATION

  FileUtils.mkdir(@temp_file_directory)
end

After do
  FileUtils.remove_dir(@temp_file_directory, true)
end
