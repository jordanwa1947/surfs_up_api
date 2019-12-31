class SpotSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :spot_id, :location
end
