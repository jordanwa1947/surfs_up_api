require 'rails_helper'

describe 'Spot Model Tests' do

  it 'performs a substring, case insensitive search and returns matching locations' do
    spot_1 = Spot.create(location: 'Hawaii', spot_id: 1)
    spot_2 = Spot.create(location: 'Newquay', spot_id: 1)
    spot_3 = Spot.create(location: 'Nashbolim', spot_id: 1)
    spot_4 = Spot.create(location: 'Nashawim', spot_id: 1)

    locations = Spot.search('haw')

    expect(locations.count).to eq(2)
    expect(locations[0]).to eq(spot_1)
    expect(locations[1]).to eq(spot_4)
  end
end
