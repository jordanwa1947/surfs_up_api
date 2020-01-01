class MswFacade
  attr_reader :location_id, :location

  def initialize(location_id, location)
    @location_id = location_id
    @location = location
  end

  def forecast
    Forecast.new(service.find_forecast, @location)
  end

private

  def service
    @service ||= MswForecastScraper.new(@location_id)
  end
end
