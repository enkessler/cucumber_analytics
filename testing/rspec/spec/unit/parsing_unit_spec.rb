require "#{File.dirname(__FILE__)}/../spec_helper"

SimpleCov.command_name('Parsing') unless RUBY_VERSION.to_s < '1.9.0'

describe 'Parsing, Unit' do

  it 'can parse text - #parse_text' do
    expect(CucumberAnalytics::Parsing.respond_to?(:parse_text)).to be true
  end

  it 'can only parse strings' do
    expect { CucumberAnalytics::Parsing.parse_text(5) }.to raise_error(ArgumentError)
    expect { CucumberAnalytics::Parsing.parse_text('Feature:') }.to_not raise_error
  end

  it 'returns an Array' do
    result = CucumberAnalytics::Parsing.parse_text('Feature:')
    expect(result).to be_a(Array)
  end

end
