require_relative 'test_helper'

describe 'BlockIntent' do
  before do
    @block_intent = Hotel::BlockIntent.new
  end

  it 'is an instance of BlockIntent' do
    expect(@block_intent).must_be_instance_of Hotel::BlockIntent
  end
end
