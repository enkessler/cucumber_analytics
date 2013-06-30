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

  it 'has features - #features' do
    @feature_file.should respond_to(:features)
  end

  it 'can get and set its features - #features, #features=' do
    @feature_file.features = :some_features
    @feature_file.features.should == :some_features
    @feature_file.features = :some_other_features
    @feature_file.features.should == :some_other_features
  end

  it 'knows how many features it has - #feature_count' do
    @feature_file.features = [:a_feature]
    @feature_file.feature_count.should == 1
    @feature_file.features = []
    @feature_file.feature_count.should == 0
  end

  it 'starts with no features' do
    @feature_file.features.should == []
  end

  it 'contains features' do
    features = [:a_feature]
    everything = features

    @feature_file.features = features

    @feature_file.contains.should =~ everything
  end

  it 'can easily access its sole feature' do
    @feature_file.features = []
    @feature_file.feature.should be_nil

    @feature_file.features = [:a_feature]
    @feature_file.feature.should == :a_feature
  end

end
