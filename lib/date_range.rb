module Hotel
  class DateRange
    attr_reader :start, :end

    def initialize start, nd
      raise ArgumentError, "start cannot be after end" if start > nd
      
      @start = start
      @end = nd
    end

    def includes? date
      date >= @start && date <= @end
    end
  end
end
