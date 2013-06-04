require 'spec_helper'

SimpleCov.command_name('FeatureFile') unless RUBY_VERSION.to_s < '1.9.0'

describe 'FeatureFile, Unit' do

  clazz = CucumberAnalytics::FeatureFile

  it_should_behave_like 'a nested element', clazz
  it_should_behave_like 'a containing element', clazz
  it_should_behave_like 'a bare bones element', clazz
  it_should_behave_like 'a prepopulated element', clazz


  before(:each) do
    @feature_file = clazz.new
  end

  it 'cannot model a non-existent directory' do
    path = "#{DEFAULT_FILE_DIRECTORY}/missing_file.txt"

    expect { CucumberAnalytics::FeatureFile.new(path) }.to raise_error(ArgumentError)
  end

  it 'knows the name of the file that it is modeling' do
    path = "#{DEFAULT_FILE_DIRECTORY}/#{DEFAULT_FEATURE_FILE_NAME}"
    File.open(path, "w") {}

    feature = CucumberAnalytics::FeatureFile.new(path)

    feature.name.should == DEFAULT_FEATURE_FILE_NAME
  end

  it 'knows the path of the file that it is modeling' do
    path = "#{DEFAULT_FILE_DIRECTORY}/#{DEFAULT_FEATURE_FILE_NAME}"
    File.open(path, "w") {}

    directory = CucumberAnalytics::FeatureFile.new(path)

    directory.path.should == path
  end

  it 'has a feature - #feature' do
    @feature_file.should respond_to(:feature)
  end

  it 'can get and set its feature - #feature, #feature=' do
    @feature_file.feature = :some_feature
    @feature_file.feature.should == :some_feature
    @feature_file.feature = :some_other_feature
    @feature_file.feature.should == :some_other_feature
  end

  it 'knows how many features it has - #feature_count' do
    @feature_file.feature = :a_feature
    @feature_file.feature_count.should == 1
    @feature_file.feature = nil
    @feature_file.feature_count.should == 0
  end

  it 'starts with no feature' do
    @feature_file.feature.should be_nil
  end

  it 'contains a feature' do
    feature = :a_feature
    everything = [feature]

    @feature_file.feature = feature

    @feature_file.contains.should =~ everything
  end

end
