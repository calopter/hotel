require_relative 'test_helper'

describe 'Reservation' do
  it 'is a reservation' do
    expect(Hotel::Reservation.new).must_be_instance_of Hotel::Reservation
  end
end
