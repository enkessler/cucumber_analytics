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
  task :test_everything => :clear_coverage


  task :test_project do |t, args|
    rspec_args = '--tag ~@wip --pattern testing/rspec/spec/**/*_spec.rb'
    cucumber_args = 'testing/cucumber/features -r testing/cucumber/support -r testing/cucumber/step_definitions -f progress -t ~@wip'

    Rake::Task['cucumber_analytics:test_everything'].invoke(rspec_args, cucumber_args)
  end

end


task :default => 'cucumber_analytics:test_project'
