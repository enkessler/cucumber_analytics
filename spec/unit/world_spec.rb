require 'spec_helper'

SimpleCov.command_name('World') unless RUBY_VERSION.to_s < '1.9.0'

describe 'World' do

  it 'can get and set the delimiters used for step argument parsing' do
    world = CucumberAnalytics::World

    world.left_delimiter = '"'
    world.right_delimiter = '"'
    world.left_delimiter.should == '"'
    world.right_delimiter.should == '"'

    world.left_delimiter = '!'
    world.right_delimiter = '!'
    world.left_delimiter.should == '!'
    world.right_delimiter.should == '!'
  end

  it 'can have different left and right delimiters' do
    world = CucumberAnalytics::World

    world.left_delimiter = '"'
    world.right_delimiter = '*'

    (world.left_delimiter != world.right_delimiter).should be_true
  end

  it 'should match left and right delimiters when only one is set' do
    world = CucumberAnalytics::World

    world.left_delimiter = nil
    world.right_delimiter = nil

    world.left_delimiter = '"'
    world.right_delimiter.should == '"'

    world.left_delimiter = nil

    world.right_delimiter = '*'
    world.left_delimiter.should == '*'
  end

end
