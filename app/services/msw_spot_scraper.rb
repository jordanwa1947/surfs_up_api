class MswSpotScraper

  def loop_through_ids(location)
    spot_id = 1
    stop = ENV['RAILS_ENV'] == 'test' ? 1 : 6900
    while spot_id <= stop do
      nokogiri_object = get_html(spot_id)
      parse_spot(nokogiri_object, location)
      spot_id += 1
      p spot_id if spot_id % 500 == 0
    end
  end

  def parse_spot(nokogiri_object, location)
    page_element = nokogiri_object.css(".msw-js-secondaryNavigation")
    if page_element[0]
      scraped_spot = page_element[0].values[1]
      surfing_spot = JSON.parse(scraped_spot, symbolize_names: true)
      database_or_csv(surfing_spot[0], location)
    end
  end

  def database_or_csv(surfing_spot, location)
    locations = {
      'database': add_to_database(surfing_spot),
      'csv': create_spots_csv(surfing_spot)
    }
    locations[location]
  end

  def create_spots_csv(spot)
    surfing_spots = File.join Rails.root, "app/data/surfing_spots.csv"
    if spot[:id] == 1
      CSV.open(surfing_spots, "w") do |csv|
        csv << ['location', 'spot_id', 'lat', 'lon']
      end
    end

    CSV.open(surfing_spots, "a") do |csv|
      csv << [spot[:name], spot[:id], spot[:coords][:lat], spot[:coords][:lon]]
    end
  end

  def add_to_database(data)
    spot = Spot.new
    spot.spot_id = data[:id]
    spot.location = data[:name]
    spot.latitude = data[:coords][:lat]
    spot.longitude = data[:coords][:lon]
    spot.save
  end

  def get_html(spot_id)
    doc = HTTParty.get("https://magicseaweed.com/Surf-Report/#{spot_id}/")
    Nokogiri::HTML(doc)
  end
end
