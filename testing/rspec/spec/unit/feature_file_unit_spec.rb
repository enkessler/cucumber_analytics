require "#{File.dirname(__FILE__)}/../spec_helper"

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

    expect(feature.name).to eq(DEFAULT_FEATURE_FILE_NAME)
  end

  it 'knows the path of the file that it is modeling' do
    path = "#{DEFAULT_FILE_DIRECTORY}/#{DEFAULT_FEATURE_FILE_NAME}"
    File.open(path, "w") {}

    directory = CucumberAnalytics::FeatureFile.new(path)

    expect(directory.path).to eq(path)
  end

  it 'has features - #features' do
    expect(@feature_file.respond_to?(:features)).to be true
  end

  it 'can get and set its features - #features, #features=' do
    @feature_file.features = :some_features
    expect(@feature_file.features).to eq(:some_features)
    @feature_file.features = :some_other_features
    expect(@feature_file.features).to eq(:some_other_features)
  end

  it 'knows how many features it has - #feature_count' do
    @feature_file.features = [:a_feature]
    expect(@feature_file.feature_count).to eq(1)
    @feature_file.features = []
    expect(@feature_file.feature_count).to eq(0)
  end

  it 'starts with no features' do
    expect(@feature_file.features).to eq([])
  end

  it 'contains features' do
    features = [:a_feature]
    everything = features

    @feature_file.features = features

    expect(@feature_file.contains).to match_array(everything)
  end

  it 'can easily access its sole feature' do
    @feature_file.features = []
    expect(@feature_file.feature).to be_nil

    @feature_file.features = [:a_feature]
    expect(@feature_file.feature).to eq(:a_feature)
  end

  context 'feature file output edge cases' do

    it 'is a String' do
      expect(@feature_file.to_s).to be_a(String)
    end

    it 'can output an empty feature file' do
      expect { @feature_file.to_s }.to_not raise_error
    end

  end

end
