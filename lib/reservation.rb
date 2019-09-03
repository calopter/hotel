module Hotel
  class Reservation
    attr_reader :room, :date_range

    def initialize room, date_range
      @room = room
      @date_range = date_range
    end

    def cost
      rate * @date_range.nights.count
    end

    def rate
      200
    end
  end
end
