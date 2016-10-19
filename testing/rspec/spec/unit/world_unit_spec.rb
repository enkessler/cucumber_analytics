require 'spec_helper'

SimpleCov.command_name('World') unless RUBY_VERSION.to_s < '1.9.0'

describe 'World, Unit' do

  before(:each) do
    @world = CucumberAnalytics::World
    @world.loaded_step_patterns.clear
    @world.delimiter = nil
  end

  it 'has left and right delimiters used for step argument parsing - #left_delimiter, #right_delimiter' do
    expect(@world.respond_to?(:left_delimiter)).to be true
    expect(@world.respond_to?(:right_delimiter)).to be true
  end

  it 'can get and set the delimiters used for step argument parsing' do
    @world.left_delimiter = '"'
    @world.right_delimiter = '"'
    expect(@world.left_delimiter).to eq('"')
    expect(@world.right_delimiter).to eq('"')

    @world.left_delimiter = '!'
    @world.right_delimiter = '!'
    expect(@world.left_delimiter).to eq('!')
    expect(@world.right_delimiter).to eq('!')
  end

  it 'can have different left and right delimiters' do
    @world.left_delimiter = '"'
    @world.right_delimiter = '*'

    expect(@world.left_delimiter).to_not eq(@world.right_delimiter)
  end

  it 'can set both of its delimiters at once - #delimiter=' do
    @world.delimiter = '*'

    expect(@world.left_delimiter).to eq('*')
    expect(@world.right_delimiter).to eq('*')
  end

  it 'starts with no delimiters' do
    expect(@world.left_delimiter).to be_nil
    expect(@world.right_delimiter).to be_nil
  end

  context 'step patterns' do

    it 'can load step patterns - #load_step_pattern' do
      expect(@world.respond_to?(:load_step_pattern)).to be true
    end

    it 'starts with no patterns loaded' do
      expect(@world.loaded_step_patterns).to eq([])
    end

    it 'keeps track of loaded step patterns - #loaded_step_patterns' do
      patterns = [/a pattern/, /another pattern/]

      patterns.each do |pattern|
        @world.load_step_pattern(pattern)
      end

      expect(@world.loaded_step_patterns).to match_array(patterns)
    end

    it 'can load step definition files - #load_step_file' do
      file_path = "#{@default_file_directory}/step_file.rb"
      patterns = [/a pattern/, /another pattern/]

      File.open(file_path, 'w') { |file|
        patterns.each do |pattern|
          file.puts "Given #{pattern.inspect} do end"
        end
      }

      @world.load_step_file(file_path)

      expect(@world.loaded_step_patterns).to match_array(patterns)
    end

    it 'can handle different step keywords - #load_step_file' do
      file_path = "#{@default_file_directory}/step_file.rb"
      patterns = [/given pattern/, /when pattern/, /then pattern/, /and pattern/, /but pattern/]

      File.open(file_path, 'w') { |file|
        file.puts "Given #{patterns[0].inspect} do end"
        file.puts "When #{patterns[1].inspect} do end"
        file.puts "Then #{patterns[2].inspect} do end"
        file.puts "And #{patterns[3].inspect} do end"
        file.puts "But #{patterns[4].inspect} do end"
      }

      @world.load_step_file(file_path)

      expect(@world.loaded_step_patterns).to match_array(patterns)
    end

    it 'can handle a variety of declaration structures - #load_step_file' do
      file_path = "#{@default_file_directory}/step_file.rb"
      patterns = [/parentheses pattern/, /no parentheses pattern/, /excess whitespace pattern/]

      File.open(file_path, 'w') { |file|
        file.puts "Given(#{patterns[0].inspect}) do end"
        file.puts "Given #{patterns[1].inspect} do end"
        file.puts "Given   #{patterns[2].inspect}   do end"
      }

      @world.load_step_file(file_path)

      expect(@world.loaded_step_patterns).to match_array(patterns)
    end

    it 'can clear its loaded step patterns - #clear_step_patterns' do
      patterns = [/a pattern/, /another pattern/]

      patterns.each do |pattern|
        @world.load_step_pattern(pattern)
      end

      expect(@world.loaded_step_patterns).to match_array(patterns)
      @world.clear_step_patterns
      expect(@world.loaded_step_patterns).to eq([])
    end

  end

  context 'collecting stuff' do

    before(:each) do
      @set_1 = [:thing_1, :thing_2]
      @set_2 = [:thing_3]
    end

    it 'can collect tags from containers' do
      nested_container = double(:tags => @set_2, :tag_elements => @set_2)
      container = double(:tags => @set_1, :tag_elements => @set_1, :contains => [nested_container])

      expect(@world.tags_in(container)).to match_array((@set_1 + @set_2))
      expect(@world.tag_elements_in(container)).to match_array((@set_1 + @set_2))
    end

    it 'can collect directories from containers' do
      nested_container = double(:directories => @set_2)
      container = double(:directories => @set_1, :contains => [nested_container])

      expect(@world.directories_in(container)).to match_array((@set_1 + @set_2))
    end

    it 'can collect feature files from containers' do
      nested_container = double(:feature_files => @set_2)
      container = double(:feature_files => @set_1, :contains => [nested_container])

      expect(@world.feature_files_in(container)).to match_array((@set_1 + @set_2))
    end

    it 'can collect features from containers' do
      nested_container = double(:features => @set_2)
      container = double(:features => @set_1, :contains => [nested_container])

      expect(@world.features_in(container)).to match_array((@set_1 + @set_2))
    end

    it 'can collect tests from containers' do
      nested_container = double(:tests => @set_2)
      container = double(:tests => @set_1, :contains => [nested_container])

      expect(@world.tests_in(container)).to match_array((@set_1 + @set_2))
    end

    it 'can collect steps from containers' do
      nested_container = double(:steps => @set_2)
      container = double(:steps => @set_1, :contains => [nested_container])

      expect(@world.steps_in(container)).to match_array((@set_1 + @set_2))
    end

  end

end
