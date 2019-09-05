require_relative 'test_helper'

describe 'DateRange' do
  before do
    @base_date = Date.jd 2458730 
    @start = @base_date
    @end = @base_date.next
    
    @one_night = Hotel::DateRange.new @start, @end
    @two_nights = Hotel::DateRange.new @start, @end.next
  end

  describe '#initialize' do
    it 'is a DateRange' do
      expect(@one_night).must_be_instance_of Hotel::DateRange
    end

    it 'accepts and returns a start and an end' do
      expect(@one_night.start).must_be_instance_of Date    
      expect(@one_night.end).must_be_instance_of Date    
    end

    it 'raises ArgumentError if start is after end' do
      expect { Hotel::DateRange.new @end, @start }.must_raise ArgumentError
    end
  end

  describe '#includes?' do
    it 'returns true if date is in the date range' do
      expect(@one_night.includes? @base_date).must_equal true
      expect(@one_night.includes? @end).must_equal true
    end

    it 'returns false if date is not in the date range' do
      day = Date.jd 3
      expect(@one_night.includes? day).must_equal false
      expect(@one_night.includes? @end.next).must_equal false
    end
  end

  describe '#nights' do
    it 'returns a set of Date instances' do
      expect(@one_night.nights).must_be_instance_of Set
      expect(@one_night.nights.count).must_equal 1
      expect(@one_night.nights.first).must_be_instance_of Date
    end
  end

  describe '#overlaps?' do
    it 'returns true if the ranges overlap' do
      other_range = Hotel::DateRange.new(@start, @end.succ)
      expect(@one_night.overlaps? other_range).must_equal true 
    end

    it 'returns false if the ranges do not overlap' do
      after = Hotel::DateRange.new(@end, @end.next)
      before = Hotel::DateRange.new(@start.prev_day, @start)
      
      expect(@one_night.overlaps? after).must_equal false
      expect(@one_night.overlaps? before).must_equal false
    end
  end
end
