require_relative 'reservation'

module Hotel
  class Booker
    attr_reader :rooms, :reservations

    def initialize
      @rooms = (1..20).to_a
      @reservations = []
    end

    def add_reservation room, date_range
      reservation = Reservation.new(room, date_range)
      @reservations << reservation
      reservation
    end
  end
end
