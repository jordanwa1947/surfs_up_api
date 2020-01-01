require 'rails_helper'

describe 'Spot Scraper Service' do
  it 'finds a pages location and id info' do
    VCR.use_cassette('surf_guide') do
      service = MswSpotScraper.new()

      service.loop_through_ids
      spot = Spot.first

      expect(spot.location).to eq("Newquay - Fistral North")
      expect(spot.spot_id).to eq(1)
      expect(spot.location_coords.coordinates).to eq([50.4184, -5.0997])
    end
  end
end
