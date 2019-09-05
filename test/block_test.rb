require_relative 'test_helper'

describe 'Block' do
  before do
    date_range = Hotel::DateRange.new Date.today, Date.today.next
    rooms = (1..5).to_a
    rate = 100
    @block = Hotel::Block.new date_range, rooms, rate
  end
  
  it 'is an instance of Block' do
    expect(@block).must_be_instance_of Hotel::Block
  end
end
