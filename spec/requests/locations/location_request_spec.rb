require 'rails_helper'

describe 'Locations API' do
  it 'sends a list of all locations' do
    spot_1 = Spot.create(location: 'Hawaii', spot_id: 1)
    spot_2 = Spot.create(location: 'Newquay', spot_id: 1)
    spot_3 = Spot.create(location: 'Nashbolim', spot_id: 1)

    get '/api/v1/locations'

    expect(response).to be_successful

    locations = JSON.parse(response.body)

    expect(locations.class).to eq(Hash)
    expect(locations["data"].count).to eq(3)
    expect(locations["data"][0]["attributes"]["location"]).to eq(spot_1.location)
    expect(locations["data"][1]["attributes"]["location"]).to eq(spot_2.location)
    expect(locations["data"][2]["attributes"]["location"]).to eq(spot_3.location)
  end

  it 'sends locations matching a search' do
    spot_1 = Spot.create(location: 'Hawaii', spot_id: 1)
    spot_2 = Spot.create(location: 'Newquay', spot_id: 1)
    spot_3 = Spot.create(location: 'Nashbolim', spot_id: 1)
    spot_4 = Spot.create(location: 'Nashawim', spot_id: 1)

    get '/api/v1/search/locations?query=haw'

    expect(response).to be_successful

    locations = JSON.parse(response.body)

    expect(locations["data"].count).to eq(2)
    expect(locations["data"][0]["attributes"]["location"]).to eq(spot_1.location)
    expect(locations["data"][0]["attributes"]["id"]).to eq(spot_1.id)
    expect(locations["data"][1]["attributes"]["location"]).to eq(spot_4.location)
    expect(locations["data"][1]["attributes"]["id"]).to eq(spot_4.id)
  end
end
