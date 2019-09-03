require_relative 'test_helper.rb'

describe 'Booker' do
  it 'is a Booker' do
    expect(Hotel::Booker.new).must_be_instance_of Hotel::Booker
  end
end
