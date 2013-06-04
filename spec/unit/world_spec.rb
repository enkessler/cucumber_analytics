require 'spec_helper'

SimpleCov.command_name('World') unless RUBY_VERSION.to_s < '1.9.0'

describe 'World, Unit' do

  before(:each) do
    @world = CucumberAnalytics::World
    @world.loaded_step_patterns.clear
    @world.delimiter = nil
  end

  it 'has left and right delimiters used for step argument parsing - #left_delimiter, #right_delimiter' do
    @world.should respond_to(:left_delimiter)
    @world.should respond_to(:right_delimiter)
  end

  it 'can get and set the delimiters used for step argument parsing' do
    @world.left_delimiter = '"'
    @world.right_delimiter = '"'
    @world.left_delimiter.should == '"'
    @world.right_delimiter.should == '"'

    @world.left_delimiter = '!'
    @world.right_delimiter = '!'
    @world.left_delimiter.should == '!'
    @world.right_delimiter.should == '!'
  end

  it 'can have different left and right delimiters' do
    @world.left_delimiter = '"'
    @world.right_delimiter = '*'

    (@world.left_delimiter != @world.right_delimiter).should be_true
  end

  it 'can set both of its delimiters at once - #delimiter=' do
    @world.delimiter = '*'

    @world.left_delimiter.should == '*'
    @world.right_delimiter.should == '*'
  end

  it 'starts with no delimiters' do
    @world.left_delimiter.should == nil
    @world.right_delimiter.should == nil
  end

  it 'can load step patterns - #load_step_pattern' do
    @world.should respond_to(:load_step_pattern)
  end

  it 'starts with no patterns loaded' do
    @world.loaded_step_patterns.should == []
  end

  it 'keeps track of loaded step patterns - #loaded_step_patterns' do
    patterns = [/a pattern/, /another pattern/]

    patterns.each do |pattern|
      @world.load_step_pattern(pattern)
    end

    @world.loaded_step_patterns.should =~ patterns
  end

  it 'can load step definition files - #load_step_file' do
    file_path = "#{DEFAULT_FILE_DIRECTORY}/step_file.rb"
    patterns = [/a pattern/, /another pattern/]

    File.open(file_path, 'w') { |file|
      patterns.each do |pattern|
        file.puts "Given #{pattern.inspect} do end"
      end
    }
    @world.load_step_file(file_path)

    @world.loaded_step_patterns.should =~ patterns
  end

  context 'collecting stuff' do

    before(:each) do
      @set_1 = [:thing_1, :thing_2]
      @set_2 = [:thing_3]
    end

    it 'can collect tags from containers' do
      nested_container = double(:tags => @set_2)
      container = double(:tags => @set_1, :contains => [nested_container])

      @world.tags_in(container).should =~ (@set_1 + @set_2)
    end

    it 'can collect directories from containers' do
      nested_container = double(:directories => @set_2)
      container = double(:directories => @set_1, :contains => [nested_container])

      @world.directories_in(container).should =~ (@set_1 + @set_2)
    end

    it 'can collect feature files from containers' do
      nested_container = double(:feature_files => @set_2)
      container = double(:feature_files => @set_1, :contains => [nested_container])

      @world.feature_files_in(container).should =~ (@set_1 + @set_2)
    end

    it 'can collect features from containers' do
      nested_container = double(:feature => :thing_1)
      container = double(:feature => :thing_2, :contains => [nested_container])

      @world.features_in(container).should =~ [:thing_1, :thing_2]
    end

    it 'can collect tests from containers' do
      nested_container = double(:tests => @set_2)
      container = double(:tests => @set_1, :contains => [nested_container])

      @world.tests_in(container).should =~ (@set_1 + @set_2)
    end

    it 'can collect steps from containers' do
      nested_container = double(:steps => @set_2)
      container = double(:steps => @set_1, :contains => [nested_container])

      @world.steps_in(container).should =~ (@set_1 + @set_2)
    end

  end

end
