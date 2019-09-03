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

    def overlaps? date_range
      nights.intersect? date_range.nights 
    end

    def nights
      @start.upto(@end.prev_day).to_set
    end
  end
end
