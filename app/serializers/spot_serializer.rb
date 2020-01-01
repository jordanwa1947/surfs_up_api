class SpotSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :spot_id, :location
  attribute :location_coords do |object|
    point = object.location_coords
    if point
      {lat: point.coordinates[0], lon: point.coordinates[1]}
    end
  end
end
