#!/usr/bin/env rake
require "bundler/gem_tasks"
require 'racatt'

namespace 'cucumber_analytics' do

  task :clear_coverage do
    code_coverage_directory = "#{File.dirname(__FILE__)}/coverage"

    FileUtils.remove_dir(code_coverage_directory, true)
  end


  Racatt.create_tasks

  # Redefining the task from 'racatt' in order to clear the code coverage results
  task :test_everything, [:command_options] => :clear_coverage

end


task :default => 'cucumber_analytics:test_everything'
