module Hotel
  class Booker
    attr_reader :rooms

    def initialize
      @rooms = (1..20).to_a
    end
  end
end
