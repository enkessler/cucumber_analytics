require 'simplecov'
SimpleCov.start

require 'wrong'
include Wrong

require File.dirname(__FILE__) + '/../../lib/cucumber_analytics'

Log4r::Logger.root.level = Log4r::OFF

Log4r::FileOutputter.new('logfile',
                         :filename=>'test_log.txt',
                         :trunc=>true,
                         :level=>Log4r::DEBUG)

CucumberAnalytics::Logging.logger.add('logfile')


DEFAULT_FEATURE_FILE_NAME = 'test_feature.feature'
DEFAULT_STEP_FILE_NAME = 'test_steps.rb'
DEFAULT_FILE_DIRECTORY = "#{File.dirname(__FILE__)}/../temp_files"
TEST_FILE_DIRECTORY = "#{File.dirname(__FILE__)}/../test_files"
TEST_STEP_FILE_LOCATION = "#{DEFAULT_FILE_DIRECTORY}/#{DEFAULT_STEP_FILE_NAME}"


Before do
  @default_feature_file_name = DEFAULT_FEATURE_FILE_NAME
  @default_step_file_name = DEFAULT_STEP_FILE_NAME
  @test_file_directory = TEST_FILE_DIRECTORY
  @default_file_directory = DEFAULT_FILE_DIRECTORY
  @test_step_file_location = TEST_STEP_FILE_LOCATION

  FileUtils.mkdir(@default_file_directory)
end

After do
  FileUtils.remove_dir(@default_file_directory, true)
end
