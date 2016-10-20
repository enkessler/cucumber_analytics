require 'simplecov' unless RUBY_VERSION.to_s < '1.9.0'

# Ruby 1.8.x seems to have trouble if relative paths get too nested, so resolving the path before using it here
this_dir = File.expand_path(File.dirname(__FILE__))
require "#{this_dir}/../../../lib/cucumber_analytics"

require "#{this_dir}/unit/feature_element_unit_specs"
require "#{this_dir}/unit/nested_element_unit_specs"
require "#{this_dir}/unit/tagged_element_unit_specs"
require "#{this_dir}/unit/containing_element_unit_specs"
require "#{this_dir}/unit/bare_bones_unit_specs"
require "#{this_dir}/unit/test_element_unit_specs"
require "#{this_dir}/unit/prepopulated_unit_specs"
require "#{this_dir}/unit/sourced_element_unit_specs"
require "#{this_dir}/unit/raw_element_unit_specs"


DEFAULT_FEATURE_FILE_NAME = 'test_feature.feature'
DEFAULT_FILE_DIRECTORY = "#{this_dir}/temp_files"


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
