require_relative 'test_helper.rb'

describe 'Booker' do
  before do
    @start = Date.today
    @end = Date.today
    @booker = Hotel::Booker.new
  end

  describe '#initialize' do
    it 'is a Booker' do
      expect(@booker).must_be_instance_of Hotel::Booker
    end

    it 'can return all its rooms' do
      expect(@booker.rooms).must_be_instance_of Array
      expect(@booker.rooms.count).must_equal 20
    end

    it 'has Reservations' do
      expect(@booker.reservations).must_be_instance_of Array
    end
  end

  describe '#add_reservation' do
    it 'stores a reservation' do
      reservation = @booker.add_reservation @start, @end
      
      expect(reservation).must_be_instance_of Hotel::Reservation
      expect(@booker.reservations.first).must_equal reservation
    end
  end
end
