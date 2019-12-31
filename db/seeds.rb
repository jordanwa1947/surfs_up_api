# Uncomment the following lines to clear the data base
# though expect this process to take upto an hour
# require 'database_cleaner'

# DatabaseCleaner.strategy = :truncation
# DatabaseCleaner.clean
# scraper = MswSpotScraper.new
# scraper.loop_through_ids

surfing_spots = File.join Rails.root, "app/data/surfing_spots.csv"
CSV.foreach(surfing_spots, headers: true) do |row|
  spot = Spot.new
  spot.location = row['location']
  spot.id = row['spot_id']
  spot.save
end
