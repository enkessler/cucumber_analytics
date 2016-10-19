require "#{File.dirname(__FILE__)}/../spec_helper"

SimpleCov.command_name('Directory') unless RUBY_VERSION.to_s < '1.9.0'

describe 'Directory, Unit' do

  clazz = CucumberAnalytics::Directory

  it_should_behave_like 'a nested element', clazz
  it_should_behave_like 'a containing element', clazz
  it_should_behave_like 'a bare bones element', clazz
  it_should_behave_like 'a prepopulated element', clazz

  before(:each) do
    @directory = clazz.new
  end

  it 'cannot model a non-existent directory' do
    path = "#{DEFAULT_FILE_DIRECTORY}/missing_directory"

    expect { CucumberAnalytics::Directory.new(path) }.to raise_error(ArgumentError)
  end

  it 'knows the name of the directory that it is modeling' do
    path = "#{DEFAULT_FILE_DIRECTORY}"

    directory = CucumberAnalytics::Directory.new(path)

    expect(directory.name).to eq('temp_files')
  end

  it 'knows the path of the directory that it is modeling' do
    path = "#{DEFAULT_FILE_DIRECTORY}"

    directory = CucumberAnalytics::Directory.new(path)

    expect(directory.path).to eq(path)
  end

  it 'has feature files - #feature_files' do
    expect(@directory.respond_to?(:feature_files)).to be true
  end

  it 'can get and set its feature files - #feature_files, #feature_files=' do
    @directory.feature_files = :some_feature_files
    expect(@directory.feature_files).to eq(:some_feature_files)
    @directory.feature_files = :some_other_feature_files
    expect(@directory.feature_files).to eq(:some_other_feature_files)
  end

  it 'knows how many feature files it has - #feature_file_count' do
    @directory.feature_files = [:file_1, :file_2, :file_3]

    expect(@directory.feature_file_count).to eq(3)
  end

  it 'has directories - #directories' do
    expect(@directory.respond_to?(:directories)).to be true
  end

  it 'can get and set its directories - #directories, #directories=' do
    @directory.directories = :some_directories
    expect(@directory.directories).to eq(:some_directories)
    @directory.directories = :some_other_directories
    expect(@directory.directories).to eq(:some_other_directories)
  end

  it 'knows how many directories it has - #directory_count' do
    @directory.directories = [:directory_1, :directory_2, :directory_3]

    expect(@directory.directory_count).to eq(3)
  end

  it 'starts with no feature files or directories' do
    expect(@directory.feature_files).to eq([])
    expect(@directory.directories).to eq([])
  end

  it 'contains feature files and directories' do
    directories = [:directory_1, :directory_2, :directory_3]
    files = [:file_1, :file_2, :file_3]
    everything = files + directories

    @directory.directories = directories
    @directory.feature_files = files

    expect(@directory.contains).to match_array(everything)
  end

  context 'directory output edge cases' do

    it 'is a String' do
      expect(@directory.to_s).to be_a(String)
    end

    it 'can output an empty directory' do
      expect { @directory.to_s }.to_not raise_error
    end

  end

end

