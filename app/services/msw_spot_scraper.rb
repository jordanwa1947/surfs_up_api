class MswSpotScraper

  def loop_through_ids
    spot_id = 1
    stop = ENV['RAILS_ENV'] == 'test' ? 1 : 6900
    while spot_id <= stop do
      nokogiri_object = get_html(spot_id)
      parse_spots(nokogiri_object)
      spot_id += 1
      p spot_id if spot_id % 500 == 0
    end
  end

  def parse_spots(nokogiri_object)
    page_element = nokogiri_object.css(".msw-js-secondaryNavigation")
    if page_element[0]
      scraped_spot = page_element[0].values[1]
      surfing_spot = JSON.parse(scraped_spot, symbolize_names: true)
      add_to_database(surfing_spot[0])
    end
  end

  def add_to_database(data)
    spot = Spot.new
    spot.spot_id = data[:id]
    spot.location = data[:name]
    spot.location_coords = "POINT(#{data[:coords][:lat]} #{data[:coords][:lon]})"
    spot.save
  end

  def get_html(spot_id)
    doc = HTTParty.get("https://magicseaweed.com/Surf-Report/#{spot_id}/")
    Nokogiri::HTML(doc)
  end
end
