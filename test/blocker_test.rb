require_relative 'test_helper'
require 'pry'

describe 'Blocker' do
  before do
    date_range = Hotel::DateRange.new Date.today, Date.today.next
    rooms = (1..5).to_a
    @booker = Hotel::Booker.new(rooms: (1..20).to_a)
    @blocker = Hotel::Blocker.new(id: 0, date_range: date_range, rooms: rooms, reservations: @booker.reservations)
    binding.pry
  end

  describe 'initialize' do
    it 'is an instance of Block' do
      expect(@blocker).must_be_instance_of Hotel::Blocker
    end

    it 'has superclass methods' do
      [:reserve, :reservations_on,
      :available?, :availabilities, :reservations].each do |method|
        expect(@blocker).must_respond_to method
      end
    end

    it 'raises ArgumentError if a room is unavailable' do
      room, d_r = @blocker.rooms.first, @blocker.date_range
      @booker.reserve d_r, room: room
      
      avail = @booker.available?(room: room, date_range: d_r)
      expect(avail).must_equal false
      
      avail = @blocker.available?(room: room, date_range: d_r)
      expect(avail).must_equal false

      expect(@blocker.reservations.count).must_equal 1
      expect(@booker.reservations.count).must_equal 1
      
      
      expect{ Hotel::Blocker.new(id: 0, date_range: d_r, rooms: @blocker.rooms,
                               reservations: @booker.reservations)
            }.must_raise ArgumentError
    end

    it 'blocks new reservations in the block from Booker' do
      @blocker.rooms.each do |room|
        avail = @booker.available?(room: room, date_range: @blocker.date_range)       
        expect(avail).must_equal false
      end
    end
  end

  describe '#reserve' do
    it 'stores and returns a reservation' do
      new_reservation = @blocker.reserve
      that_reservation = @blocker.reservations.first

      expect(that_reservation).must_be_instance_of Hotel::Reservation
      expect(that_reservation).must_equal new_reservation
      expect(that_reservation.date_range).must_equal @blocker.date_range
    end

    it 'stores that reservation such that Booker can see it' do
      reservation = @blocker.reserve
      expect(@booker.reservations.count).must_equal 1
      expect(@booker.reservations).must_include reservation
    end

    it 'picks a room in the block' do
      @blocker.rooms.count.times do
        expect(@blocker.rooms).must_include @blocker.reserve.room
      end
    end

    it 'picks an available room' do
      4.times { @blocker.reserve }
      reservation = @blocker.reserve
      expect(reservation.room).must_equal @blocker.rooms.last
    end

    it 'raises RuntimeError if no availabilities in block' do
      5.times { @blocker.reserve }
      expect{ @blocker.reserve }.must_raise RuntimeError
    end
  end
end
