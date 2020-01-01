require 'rails_helper'

describe 'Surf Requests' do
  it 'sends surf information corresponding to a spot id' do
    VCR.use_cassette('msw_webpage') do
      spot_1 = Spot.create(location: 'Hawaii', spot_id: 1, location_coords: "POINT(50.4184 -5.0997)")
      spot_2 = Spot.create(location: 'Newquay', spot_id: 1)
      spot_3 = Spot.create(location: 'Nashbolim', spot_id: 1)

      get '/api/v1/1/surf'

      expect(response).to be_successful

      json = JSON.parse(response.body, symbolize_names: true)

      attributes = json[:data][:attributes]

      expect(attributes[:faded_rating]).to eq(0)
      expect(attributes[:solid_rating]).to eq(2)
      expect(attributes[:min_break_height]).to eq(3)
      expect(attributes[:max_break_height]).to eq(4)
      expect(attributes[:wave_unit]).to eq('ft')
      expect(attributes[:wind_direction]).to eq('ESE')
      expect(attributes[:wind_speed]).to eq(11)
      expect(attributes[:wind_gusts]).to eq(18)
      expect(attributes[:wind_unit]).to eq('mph')
      expect(attributes[:temperature]).to eq(48)
      expect(attributes[:temperature_unit]).to eq('f')
      expect(attributes[:charts].count).to eq(4)
      expect(attributes[:location][:location]).to eq('Hawaii')
    end
  end
end
