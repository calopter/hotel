require_relative 'reservation'

module Hotel
  class Booker
    attr_reader :rooms

    def initialize rooms:, rate: 200
      @rooms = rooms
      @rate = rate
      @reservations = []
    end

    def reserve date_range, room: nil, local_res: nil
      room ||= find_room date_range
      raise ArgumentError, "invalid room" unless @rooms.include? room
      
      reservation = Reservation.new(date_range: date_range, rate: @rate, room: room)
      @reservations << reservation
      local_res << reservation if local_res
      reservation
    end

    def find_room date_range
      rooms = availabilities(date_range)
      raise RuntimeError, "no availabilities for those dates" if rooms.empty?
      rooms.first
    end

    def reservations_on date
      @reservations.select { |r| r.date_range.includes? date }
    end

    def available? room:, date_range:
      reservations.select do |r|
        (r.room == room) && (r.date_range.overlaps? date_range)
      end.none?
    end

    def availabilities date_range
      @rooms.select { |room| available?(room: room, date_range: date_range) }
    end

    def reservations
      @reservations
    end

    def list_reservations
      reservations.reject { |r| r.instance_of? Block }
    end
  end
end
