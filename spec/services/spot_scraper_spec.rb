require 'rails_helper'

describe 'Spot Scraper Service' do
  it 'finds a pages location and id info' do
    VCR.use_cassette('surf_guide') do
      service = MswSpotScraper.new()

      service.loop_through_ids('database')
      spot = Spot.first

      expect(spot.location).to eq("Newquay - Fistral North")
      expect(spot.spot_id).to eq(1)
      expect(spot.location_coords.coordinates).to eq([50.4184, -5.0997])
    end
  end

  it 'loads spots into a csv' do
    VCR.use_cassette('surf_guide') do
      service = MswSpotScraper.new()

      service.loop_through_ids('csv')

      surfing_spots = File.join Rails.root, "app/data/surfing_spots.csv"

      CSV.foreach(surfing_spots, headers: true) do |row|
        spot = Spot.new
        spot.location = row['location']
        spot.spot_id = row['spot_id']
        spot.location_coords = "POINT(#{row['lat']} #{row['lon']})"
        spot.save
      end

      spot = Spot.first
      expect(spot.location).to eq("Newquay - Fistral North")
      expect(spot.spot_id).to eq(1)
      expect(spot.location_coords.coordinates).to eq([50.4184, -5.0997])
    end
  end
end
