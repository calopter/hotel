require_relative 'test_helper'

describe 'DateRange' do
  before do
    @start = Date.jd 2458730
    @end = Date.jd 2458731
    
    @date_range = Hotel::DateRange.new @start, @end
  end
  
  it 'is a DateRange' do
    expect(@date_range).must_be_instance_of Hotel::DateRange
  end

  it 'accepts and returns a start and an end' do
    expect(@date_range.start).must_be_instance_of Date    
    expect(@date_range.end).must_be_instance_of Date    
  end

  xit 'raises ArgumentError if start is after end' do
    
  end
end
