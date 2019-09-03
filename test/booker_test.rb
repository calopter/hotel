require_relative 'test_helper.rb'

describe 'Booker' do
  before do
    @booker = Hotel::Booker.new
  end
  
  it 'is a Booker' do
    expect(@booker).must_be_instance_of Hotel::Booker
  end

  it 'can return all its rooms' do
    expect(@booker.rooms).must_be_instance_of Array
    expect(@booker.rooms.count).must_equal 20
  end
end
