module Hotel
  class DateRange
    attr_reader :start, :end

    def initialize start, nd
      @start = start
      @end = nd
    end
  end
end
