require 'simplecov' unless RUBY_VERSION.to_s < '1.9.0'

require "#{File.dirname(__FILE__)}/../lib/cucumber_analytics"

require "#{File.dirname(__FILE__)}/unit/feature_element_specs"
require "#{File.dirname(__FILE__)}/unit/inheriting_element_specs"
require "#{File.dirname(__FILE__)}/unit/nested_element_specs"
require "#{File.dirname(__FILE__)}/unit/tagged_element_specs"
require "#{File.dirname(__FILE__)}/unit/containing_element_specs"
require "#{File.dirname(__FILE__)}/unit/bare_bones_specs"
require "#{File.dirname(__FILE__)}/unit/test_element_specs"
require "#{File.dirname(__FILE__)}/unit/prepopulated_specs"

CucumberAnalytics::Logging.log_level = Logger::FATAL


DEFAULT_FEATURE_FILE_NAME = 'test_feature.feature'
DEFAULT_FILE_DIRECTORY = "#{File.dirname(__FILE__)}/temp_files"


RSpec.configure do |config|
  config.before(:all) do
    @default_feature_file_name = DEFAULT_FEATURE_FILE_NAME
    @default_file_directory = DEFAULT_FILE_DIRECTORY
  end

  config.before(:each) do
    FileUtils.mkdir(@default_file_directory)
  end

  config.after(:each) do
    FileUtils.remove_dir(@default_file_directory, true)
  end
end
