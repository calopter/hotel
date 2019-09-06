module Hotel
  class Block < Booker
    attr_reader :date_range
    
    def initialize id:, date_range:, rooms:, rate: 100, reservations: 
      super(rooms: rooms, rate: rate)
      @date_range = date_range
      @reservations = reservations
    end

    def reserve
      super @date_range
    end
  end
end
