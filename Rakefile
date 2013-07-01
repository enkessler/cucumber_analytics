#!/usr/bin/env rake
require "bundler/gem_tasks"
require 'cucumber/rake/task'
require 'rspec/core/rake_task'


desc 'Run all acceptance tests for the gem'
Cucumber::Rake::Task.new(:tests)

desc 'Run all API specifications for the gem'
RSpec::Core::RakeTask.new(:specs)

desc 'Run All The Things'
task :everything do
  Rake::Task[:specs].invoke
  Rake::Task[:tests].invoke
end

task :default => :everything
