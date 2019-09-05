module Hotel
  class Reservation
    attr_reader :room, :date_range

    def initialize args={}
      @room = args[:room]
      @date_range = args[:date_range]
      @rate = args[:rate]
    end

    def cost
      @rate * @date_range.nights.count
    end
  end
end
