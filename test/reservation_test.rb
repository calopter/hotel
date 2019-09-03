require_relative 'test_helper'

describe 'Reservation' do
  before do
    date_range = Hotel::DateRange.new Date.today, Date.today
    @reservation = Hotel::Reservation.new date_range
  end
  
  it 'is a reservation' do
    expect(@reservation).must_be_instance_of Hotel::Reservation
  end

  it 'has a date range' do
    expect(@reservation.days).must_be_instance_of Hotel::DateRange
  end
end
