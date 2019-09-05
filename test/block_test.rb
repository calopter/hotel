require_relative 'test_helper'

describe 'Block' do
  before do
    @start = Date.today
    @end = Date.today.next
    @short_stay = Hotel::DateRange.new @start, @end
    @rooms = (1..5).to_a
    rate = 100
    @block = Hotel::Block.new @short_stay, @rooms, rate
  end
  
  describe '#initialize' do
    it 'is an instance of Block' do
      expect(@block).must_be_instance_of Hotel::Block
    end

    it 'has superclass methods' do
      [:reserve, :add_reservation, :reservations_on, :available?, :availabilities, :reservations].each do |method|
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
      expect(that_reservation.date_range).must_equal @short_stay
    end

    it 'picks a room in the block' do
      5.times { expect(@rooms).must_include @block.reserve.room }
    end

    it 'picks an available room' do
      4.times { @block.reserve }
      reservation = @block.reserve 

      expect(reservation.room).must_equal @block.rooms.last    end

    it 'raises RuntimeError if no availabilities in block' do
      5.times { @block.reserve }
      expect{ @block.reserve }.must_raise RuntimeError
    end
  end
end
