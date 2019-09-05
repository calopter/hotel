module Hotel
  class Block < Booker
    def initialize date_range, rooms, rate, revervations=[]
      super rooms, rate
      @date_range = date_range
      @reservations = revervations
    end

    def reserve
      super @date_range
    end
  end
end
