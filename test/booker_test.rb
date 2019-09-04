require_relative 'test_helper.rb'

describe 'Booker' do
  before do
    @start = Date.today
    @end = Date.today.next
    @short_stay = Hotel::DateRange.new @start, @end
    @longer_stay = Hotel::DateRange.new @start, @end >> 1
    @room = 1
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

  describe '#reservations_on' do
    it 'returns an array of reservations' do
      @booker.add_reservation @room, @short_stay
      reservations = @booker.reservations_on Date.today
      
      expect(reservations).must_be_instance_of Array
      expect(reservations.count).must_equal 1
      expect(reservations.first).must_be_instance_of Hotel::Reservation
    end

    it 'returns reservations with the given date' do
      @booker.add_reservation @room, @short_stay
      
      reservations = @booker.reservations_on @start
      expect(reservations.first.date_range.start).must_equal @start

      reservations = @booker.reservations_on @end
      expect(reservations.first.date_range.end).must_equal @end
    end

    it 'does not return reservations with other dates' do
      @booker.add_reservation @room, @short_stay
      reservations = @booker.reservations_on (Date.jd 1337)
      expect(reservations.empty?).must_equal true
    end

    it 'returns an empty array if there are no reservations on that day' do
      #no reservations added yet
      reservations = @booker.reservations_on Date.today
      expect(reservations).must_be_instance_of Array
      expect(reservations.empty?).must_equal true
    end
  end
end
