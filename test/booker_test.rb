require_relative 'test_helper.rb'

describe 'Booker' do
  before do
    @start = Date.today
    @end = Date.today.next
    @short_stay = Hotel::DateRange.new @start, @end
    @longer_stay = Hotel::DateRange.new @start, @end >> 1
    @room = 1
    rooms = (1..20).to_a
    rate = 200
    @booker = Hotel::Booker.new(rooms: rooms)
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
      reservation = @booker.add_reservation @room, @short_stay
      
      expect(reservation).must_be_instance_of Hotel::Reservation
      expect(@booker.reservations.first).must_equal reservation
    end

    it 'raises ArgumentError if room doesnt exist' do
      expect { @booker.add_reservation 1337, @short_stay }.must_raise ArgumentError
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

  describe '#available? room, d_r' do
    before do
      @stay = Hotel::DateRange.new(Date.jd(1337), Date.jd(1337).next)
      @booker.add_reservation @room, @stay
    end
    
    it 'retuns true if the room has no reservations for d_r' do
      avail = @booker.available?(room: @room, date_range: @short_stay)
      expect(avail).must_equal true
    end

    it 'returns false for a room that is reserved' do
      avail = @booker.available?(room: @room, date_range: @stay)
      expect(avail).must_equal false
    end
  end

  describe '#availabilities' do
    before do
      @stay = Hotel::DateRange.new(Date.jd(1337), Date.jd(1337).next)
      @booker.add_reservation @room, @stay
    end
    
    it 'returns an array of rooms' do
      expect(@booker.availabilities @stay).must_be_instance_of Array
    end

    it 'returns only available rooms' do
      availabilities = @booker.availabilities @stay
      expect(availabilities.count).must_equal @booker.rooms.count.pred
      expect(availabilities).wont_include @room
    end
  end

  describe '#reserve' do
    it 'stores and returns a reservation for a given date_range' do
      new_reservation = @booker.reserve @short_stay
      that_reservation = @booker.reservations.first
      
      expect(that_reservation).must_be_instance_of Hotel::Reservation
      expect(that_reservation).must_equal new_reservation
      expect(that_reservation.date_range).must_equal @short_stay
    end

    it 'reserves an available room' do
      19.times { @booker.reserve @short_stay }
      reservation = @booker.reserve @short_stay

      expect(reservation.room).must_equal @booker.rooms.last
    end

    it 'raises RuntimeError if there are no availabilities' do
      20.times { @booker.reserve @short_stay }
      expect{ @booker.reserve @short_stay }.must_raise RuntimeError
    end
  end
end
