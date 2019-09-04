require_relative 'reservation'

module Hotel
  class Booker
    attr_reader :rooms, :reservations

    def initialize
      @rooms = (1..20).to_a
      @reservations = []
    end

    def add_reservation room, date_range
      raise ArgumentError, "invalid room" unless @rooms.include? room
      
      reservation = Reservation.new(room, date_range)
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
  end
end
