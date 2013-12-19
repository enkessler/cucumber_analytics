#!/usr/bin/env rake
require "bundler/gem_tasks"
require 'cucumber/rake/task'
require 'rspec/core/rake_task'

task :clear_coverage do
  code_coverage_directory = "#{File.dirname(__FILE__)}/coverage"

  FileUtils.remove_dir(code_coverage_directory, true)
end

desc 'Run all acceptance tests for the gem'
Cucumber::Rake::Task.new(:tests) do |t|
  t.cucumber_opts = "-t ~@wip -t ~@off"
end

desc 'Run all API specifications for the gem'
RSpec::Core::RakeTask.new(:specs) do |t|
  t.rspec_opts = "-t ~wip -t ~off"
end

desc 'Run All The Things'
task :everything => :clear_coverage do
  Rake::Task[:specs].invoke
  Rake::Task[:tests].invoke
end

task :default => :everything
