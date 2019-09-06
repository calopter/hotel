require_relative 'reservation'

module Hotel
  class Booker
    attr_reader :rooms, :reservations

    def initialize rooms:, rate: 200
      @rooms = rooms
      @rate = rate
      @reservations = []
    end

    def reserve date_range
      rooms = availabilities(date_range)
      raise RuntimeError, "no availabilities for those dates" if rooms.empty?
      add_reservation rooms.first, date_range
    end

    def add_reservation room, date_range
      raise ArgumentError, "invalid room" unless @rooms.include? room
      
      reservation = Reservation.new(date_range, @rate, room)
      @reservations << reservation
      reservation
    end

    def reservations_on date
      @reservations.select { |r| r.date_range.includes? date }
    end

    def available? room, date_range
      @reservations.select do |r|
        (r.room == room) && (r.date_range.overlaps? date_range)
      end.none?
    end

    def availabilities date_range
      @rooms.select { |room| available? room, date_range }
    end
  end
end
