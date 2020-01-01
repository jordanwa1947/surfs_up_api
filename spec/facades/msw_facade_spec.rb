require 'rails_helper'

describe 'Facade Methods' do
  it 'should return a formatted forecast object with info about the location' do
    VCR.use_cassette('msw_webpage') do
      spot_1 = Spot.create(location: 'Hawaii', spot_id: 1, location_coords: "POINT(50.4184 -5.0997)")

      facade = MswFacade.new(1, spot_1)

      assert_instance_of MswFacade, facade

      forecast = facade.forecast

      expect(forecast.faded_rating).to eq(0)
      expect(forecast.solid_rating).to eq(2)
      expect(forecast.issue_timestamp).to eq("Mon Dec 30 23:00:00 2019")
      expect(forecast.local_timestamp).to eq("Tue Dec 31 11:00:00 2019")
      expect(forecast.min_break_height).to eq(3)
      expect(forecast.max_break_height).to eq(4)
      expect(forecast.wave_unit).to eq('ft')
      expect(forecast.wind_speed).to eq(11)
      expect(forecast.wind_direction).to eq("ESE")
      expect(forecast.wind_gusts).to eq(18)
      expect(forecast.wind_unit).to eq('mph')
      expect(forecast.temperature).to eq(48)
      expect(forecast.temperature_unit).to eq('f')
      expect(forecast.charts.class).to eq(Hash)
    end
  end
end
