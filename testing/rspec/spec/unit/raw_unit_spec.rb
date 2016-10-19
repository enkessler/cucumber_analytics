require "#{File.dirname(__FILE__)}/../spec_helper"

SimpleCov.command_name('Raw') unless RUBY_VERSION.to_s < '1.9.0'

describe 'Raw, Unit' do

  nodule = CucumberAnalytics::Raw

  before(:each) do
    @element = Object.new.extend(nodule)
  end


  it 'has a raw element - #raw_element' do
    expect(@element.respond_to?(:raw_element)).to be true
  end

  it 'can get and set its raw element - #raw_element, #raw_element=' do
    @element.raw_element = :some_raw_element
    expect(@element.raw_element).to eq(:some_raw_element)
    @element.raw_element = :some_other_raw_element
    expect(@element.raw_element).to eq(:some_other_raw_element)
  end

end
