module Hotel
  class Book
    def initialize
      @reservations = {}
      @ids = (1..Float::INFINITY).to_enum
      @by_room = Hash.new { |h, k| h[k] = [] }
      @by_date_range = Hash.new { |h, k| h[k] = [] }
    end

    def add_reservation reservation
      id = @ids.next
      @reservations[id] = reservation
      @by_room[res.room] << res
      @by_date_range[res.date_range] << res
    end
  end
end
