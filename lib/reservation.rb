module Hotel
  class Reservation
    attr_reader :room, :date_range

    def initialize date_range, rate, room
      @room = room
      @date_range = date_range
      @rate = rate
    end

    def cost
      @rate * @date_range.nights.count
    end
  end
end
