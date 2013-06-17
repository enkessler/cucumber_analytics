require 'spec_helper'

SimpleCov.command_name('Logging') unless RUBY_VERSION.to_s < '1.9.0'

describe 'Logging, Unit' do

  before(:each) do
    @logging = CucumberAnalytics::Logging
  end

  after(:each) do
    @logging.logger.close unless @logging.logger.is_a?(Symbol)
    @logging.logger = nil
    @logging.default_logfile = nil
  end

  it 'has a logging object' do
    @logging.should respond_to(:logger)
  end

  it 'has a default logging object' do
    @logging.logger = nil

    @logging.logger.nil?.should be_false
  end

  it 'can get and set the logging object' do
    @logging.logger = :a_logger
    @logging.logger.should == :a_logger
    @logging.logger = :another_logger
    @logging.logger.should == :another_logger
  end

  it 'can get and set the current logging level' do
    @logging.logger = nil

    @logging.log_level = Logger::INFO
    @logging.log_level.should == Logger::INFO
    @logging.log_level = Logger::FATAL
    @logging.log_level.should == Logger::FATAL
  end

  it 'can get and set its default logfile' do
    @logging.default_logfile = "#{@default_file_directory}/file_1.txt"
    @logging.default_logfile.should == "#{@default_file_directory}/file_1.txt"
    @logging.default_logfile = "#{@default_file_directory}/file_2.txt"
    @logging.default_logfile.should == "#{@default_file_directory}/file_2.txt"
  end

  it 'has a default logfile' do
    gem_root = "#{File.dirname(__FILE__)}/../.."

    @logging.default_logfile = nil
    File.absolute_path(@logging.default_logfile).should == File.absolute_path("#{gem_root}/ca_logfile.log")
  end

  it 'logs to its default logfile by default' do
    @logging.logger = nil
    logfile = "#{@default_file_directory}/new_logfile.txt"

    File.exists?(logfile).should be_false

    @logging.default_logfile = logfile
    @logging.logger

    File.exists?(logfile).should be_true
  end

  it 'has a default logging level' do
    @logging.log_level.should == Logger::FATAL
  end

  it 'can log the basic properties of a method' do
    test_logfile = "#{@default_file_directory}/test_logfile.txt"
    @logging.default_logfile = test_logfile
    @logging.logger = nil
    @logging.log_level = Logger::DEBUG

    def some_method
      CucumberAnalytics::Logging.log_method(__method__)
    end

    def some_other_method(arg1,arg2, *other_args)
      CucumberAnalytics::Logging.log_method(__method__, arg1, arg2, other_args)
    end

    some_method
    some_other_method(:arg_1,:arg_2, :arg_3,:arg_4)

    logged_text = File.read(test_logfile)

    logged_text.include?('some_method').should be_true
    logged_text.include?('some_other_method').should be_true
    logged_text.include?(':arg_1').should be_true
    logged_text.include?(':arg_2').should be_true
    logged_text.include?(':arg_3').should be_true
    logged_text.include?(':arg_4').should be_true
  end

end
