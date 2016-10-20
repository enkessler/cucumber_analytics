require "#{File.dirname(__FILE__)}/../spec_helper"

shared_examples_for 'a prepopulated element' do |clazz|

  before(:each) do
    @element = clazz.new
  end

  it 'can take an argument' do
    expect(clazz.instance_method(:initialize).arity != 0).to be true
  end

end
