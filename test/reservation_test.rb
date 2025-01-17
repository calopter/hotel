require_relative 'test_helper'

describe 'Reservation' do
  before do
    date_range = Hotel::DateRange.new Date.today, Date.today.next
    room = 1
    rate = 200
    @reservation = Hotel::Reservation.new(date_range: date_range, rate: rate, room: room)
  end

  describe '#initialize' do
    it 'is a reservation' do
      expect(@reservation).must_be_instance_of Hotel::Reservation
    end

    it 'has a date range and a room' do
      expect(@reservation.date_range).must_be_instance_of Hotel::DateRange
      expect(@reservation.room).must_be_instance_of Integer
    end
  end

  describe '#cost' do
    it 'correctly calculates the cost of a reservation' do
      expect(@reservation.cost).must_equal 200
    end
  end
end
