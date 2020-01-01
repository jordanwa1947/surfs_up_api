class ForecastSerializer
  include FastJsonapi::ObjectSerializer
  attributes :faded_rating,
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
             :charts

  attribute :location do |object|
    SpotSerializer.new(object.location).serializable_hash[:data][:attributes]
  end
end
