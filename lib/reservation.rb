module Hotel
  class Reservation
    attr_reader :room, :days

    def initialize room, date_range
      @room = room
      @days = date_range
    end
  end
end
