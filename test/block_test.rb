require_relative 'test_helper'

describe 'Block' do
  before do
    date_range = Hotel::DateRange.new Date.today, Date.today.next
    rooms = (1..5).to_a
    rate = 100
    @booker = Hotel::Booker.new(rooms: (1..20).to_a)
    @block = Hotel::Block.new(id: 0, date_range: date_range, rooms: rooms, rate: rate, reservations: @booker.reservations)
  end
  
  it 'is an instance of Block' do
    expect(@block).must_be_instance_of Hotel::Block
  end
end
