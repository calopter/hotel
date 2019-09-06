require_relative 'test_helper'

describe 'Block' do
  before do
    d_r = Hotel::DateRange.new Date.today, Date.today.next
    @block = Hotel::Block.new(date_range: d_r, room: 1)
  end

  it 'is a Block' do
    expect(@block).must_be_instance_of Hotel::Block
  end
end
