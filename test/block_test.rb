require_relative 'test_helper'

describe 'Block' do
  before do
    date_range = Hotel::DateRange.new Date.today, Date.today.next
    rooms = (1..5).to_a
    @booker = Hotel::Booker.new(rooms: (1..20).to_a)
    @block = Hotel::Block.new(id: 0, date_range: date_range, rooms: rooms, reservations: @booker.reservations)
  end

  describe 'initialize' do
    it 'is an instance of Block' do
      expect(@block).must_be_instance_of Hotel::Block
    end

    it 'has superclass methods' do
      [:reserve, :add_reservation, :reservations_on,
      :available?, :availabilities, :reservations].each do |method|
        expect(@block).must_respond_to method
      end
    end
  end

  describe '#reserve' do
    it 'stores and returns a reservation' do
      new_reservation = @block.reserve
      that_reservation = @block.reservations.first

      expect(that_reservation).must_be_instance_of Hotel::Reservation
      expect(that_reservation).must_equal new_reservation
      expect(that_reservation.date_range).must_equal @block.date_range
    end

    it 'stores that reservation such that Booker can see it' do
      reservation = @block.reserve
      expect(@booker.reservations.count).must_equal 1
      expect(@booker.reservations).must_include reservation
    end

    it 'picks a room in the block' do
      @block.rooms.count.times do
        expect(@block.rooms).must_include @block.reserve.room
      end
    end

    it 'picks an available room' do
      4.times { @block.reserve }
      reservation = @block.reserve
      expect(reservation.room).must_equal @block.rooms.last
    end

    it 'raises RuntimeError if no availabilities in block' do
      5.times { @block.reserve }
      expect{ @block.reserve }.must_raise RuntimeError
    end
  end
end
