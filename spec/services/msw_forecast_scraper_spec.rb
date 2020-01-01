require 'rails_helper'

describe 'Magic Seaweed Service' do
  it 'returns wave forecast for a specific area' do
    VCR.use_cassette('msw_webpage') do

      service = MswForecastScraper.new(1)

      response = service.find_forecast

      assert_instance_of Hash, response
      expect(response).to have_key :timestamp
      expect(response[:timestamp]).to eq 1577815200
      expect(response).to have_key :swell
      expect(response[:swell][:minBreakingHeight]).to eq 3
      expect(response[:swell][:maxBreakingHeight]).to eq 4
      expect(response[:swell][:unit]).to eq "ft"
      expect(response).to have_key :wind
      expect(response[:wind][:speed]).to eq 11
      expect(response[:wind][:unit]).to eq "mph"
      expect(response).to have_key :charts
    end
  end
end
