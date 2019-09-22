module Hotel
  class Blocker < Booker
    attr_reader :date_range
    
    def initialize id:, date_range:, rooms:, rate: 100, reservations:
      super(rooms: rooms, rate: rate)
      @date_range = date_range
      @local_res = []
      @reservations = reservations

      @rooms.each do |room|
        @reservations << Block.new(date_range: date_range, room: room)
      end

      @reservations.each do |reservation|
        raise ArgumentError if (@rooms.include? reservation.room) && (reservation.instance_of? Reservation)
      end
    end

    def reserve
      reservation = super @date_range
      @local_res << reservation
      reservation
    end

    def reservations
      @local_res
    end
  end
end
