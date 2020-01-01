
rake db:{create,migrate,seed}

bundle

rake create_spots_csv

##Routes

/api/v1/location => case-insensitive, substring search returns all matching locations with their ids

/api/v1/locations => returns all locations with their ids

/api/v1/:spot_id/surf => returns the current surf at a location
