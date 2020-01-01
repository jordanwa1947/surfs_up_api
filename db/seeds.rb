# The following lines will scrape spots directly from
# magicseaweed.com and add them to the db
# scraper = MswSpotScraper.new
# scraper.loop_through_ids('database')

surfing_spots = File.join Rails.root, "app/data/surfing_spots.csv"
CSV.foreach(surfing_spots, headers: true) do |row|
  spot = Spot.new
  spot.location = row['location']
  spot.spot_id = row['spot_id']
  spot.location_coords = "POINT(#{row['lat']} #{row['lon']})"
  spot.save
end
