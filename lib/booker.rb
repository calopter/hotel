require_relative 'reservation'

module Hotel
  class Booker
    attr_reader :rooms 

    def initialize rooms, rate
      @rooms = rooms
      @rate = rate
      @reservations = []
      @blocks = []
    end

    # def block_out date_range, rooms, rate
    #   rooms.each do |room|
    #     raise ArgumentError unless available? room, date_range
    #     # this should take a hash
    #     add_reservation room, date_range, nil, true 
    #   end

    #   block = Block.new date_range, rooms, rate, @reservations
    #   @blocks << block
    #   block
    # end

    def reserve date_range
      rooms = availabilities(date_range)
      raise RuntimeError, "no availabilities for those dates" if rooms.empty?
      add_reservation({ room: (rooms.first), date_range: date_range })
    end

    def add_reservation args={}
      args[:rate] ||= @rate
      
      raise ArgumentError, "invalid room" unless @rooms.include? args[:room]
      
      reservation = Reservation.new args
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

    def reservations
      @reservations
    #   @reservations.reject { |r| r.is_a? BlockIntent }
    end
  end
end
