module Hotel
  class Reservation
    attr_reader :days

    def initialize date_range
      @days = date_range
    end
  end
end
