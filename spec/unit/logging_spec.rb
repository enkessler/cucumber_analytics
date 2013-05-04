require 'spec_helper'

SimpleCov.command_name('Logging') unless RUBY_VERSION.to_s < '1.9.0'

describe "Logging" do

  it 'has a logging object' do
    CucumberAnalytics::Logging.should respond_to(:logger)
  end

  it 'has a default logging object' do
    CucumberAnalytics::Logging.logger = nil

    CucumberAnalytics::Logging.logger.nil?.should be_false
  end

  it 'can get and set the logging object' do
    CucumberAnalytics::Logging.logger = :a_logger
    CucumberAnalytics::Logging.logger.should == :a_logger
    CucumberAnalytics::Logging.logger = :another_logger
    CucumberAnalytics::Logging.logger.should == :another_logger
  end

  before(:each) do
    CucumberAnalytics::Logging.logger = nil
  end

  it 'can get and set the current logging level' do
    CucumberAnalytics::Logging.log_level = Logger::INFO
    CucumberAnalytics::Logging.log_level.should == Logger::INFO
    CucumberAnalytics::Logging.log_level = Logger::FATAL
    CucumberAnalytics::Logging.log_level.should == Logger::FATAL
  end

  it 'keeps an internal logfile' do
    gem_root = "#{File.dirname(__FILE__)}/../.."

    CucumberAnalytics::Logging.logger

    entries = Dir.glob(gem_root + '**/logfile.log')
    entries.empty?.should be_false
  end

  it 'has a default logging level' do
    CucumberAnalytics::Logging.log_level.should == Logger::FATAL
  end

end
