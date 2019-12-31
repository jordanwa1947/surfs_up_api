require 'rails_helper'

describe 'Locations API' do
  it 'sends a list of all locations' do
    VCR.use_cassette('msw_webpage') do
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
  end
end
