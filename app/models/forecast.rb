class Forecast
  attr_reader :faded_rating,
              :solid_rating,
              :issue_timestamp,
              :local_timestamp,
              :min_break_height,
              :max_break_height,
              :wave_unit,
              :wind_direction,
              :wind_speed,
              :wind_gusts,
              :wind_unit,
              :temperature,
              :temperature_unit,
              :charts,
              :location,
              :id

  def initialize(forecast_hash, location)
    @id = location.id
    @location = location
    @faded_rating = forecast_hash[:fadedRating]
    @solid_rating = forecast_hash[:solidRating]
    @issue_timestamp = convert_to_dateime(forecast_hash[:issueTimestamp])
    @local_timestamp = convert_to_dateime(forecast_hash[:localTimestamp])
    @min_break_height = forecast_hash[:swell][:minBreakingHeight]
    @max_break_height = forecast_hash[:swell][:maxBreakingHeight]
    @wave_unit = forecast_hash[:swell][:unit]
    @wind_direction = forecast_hash[:wind][:compassDirection]
    @wind_speed = forecast_hash[:wind][:speed]
    @wind_gusts = forecast_hash[:wind][:gusts]
    @wind_unit = forecast_hash[:wind][:unit]
    @temperature = forecast_hash[:condition][:temperature]
    @temperature_unit = forecast_hash[:condition][:unit]
    @charts = forecast_hash[:charts]
  end

  def convert_to_dateime(unix_time)
    time = Time.at(unix_time).to_datetime
    time.ctime
  end
end
