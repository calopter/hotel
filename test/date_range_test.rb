require_relative 'test_helper'

describe 'DateRange' do
  before do
    @start = Date.jd 2458730
    @end = Date.jd 2458731
    
    @date_range = Hotel::DateRange.new @start, @end
  end

  describe '#initialize' do
    it 'is a DateRange' do
      expect(@date_range).must_be_instance_of Hotel::DateRange
    end

    it 'accepts and returns a start and an end' do
      expect(@date_range.start).must_be_instance_of Date    
      expect(@date_range.end).must_be_instance_of Date    
    end

    it 'raises ArgumentError if start is after end' do
      expect { Hotel::DateRange.new @end, @start }.must_raise ArgumentError
    end
  end

  describe '#includes?' do
    it 'returns true if date is in the date range' do
      day = Date.jd 2458730
      expect(@date_range.includes? day).must_equal true
    end

    it 'returns false if date is not in the date range' do
      day = Date.jd 3
      expect(@date_range.includes? day).must_equal false
    end
  end

  describe '#nights' do
    it 'returns a set of Date instances' do
      expect(@date_range.nights).must_be_instance_of Set
      expect(@date_range.nights.count).must_equal 1
      expect(@date_range.nights.first).must_be_instance_of Date
    end
  end

  describe '#overlaps?' do
    it 'returns true if the ranges overlap' do
      other_range = Hotel::DateRange.new(@start, @end.succ)
      expect(@date_range.overlaps? other_range).must_equal true 
    end

    it 'returns false if the ranges do not overlap' do
      other_range = Hotel::DateRange.new(@end, @end.succ)
      expect(@date_range.overlaps? other_range).must_equal false
    end
  end
end
