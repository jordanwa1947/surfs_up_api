
class MswForecastScraper

  def initialize(location_id)
    @location_id = location_id
  end

  def find_forecast
    nokogiri_object = get_html
    json = nokogiri_object.css('div.msw-js-current-conditions')[0].values[1]
    JSON.parse(json, symbolize_names: true)
  end


  private

  def get_html
    doc = HTTParty.get("https://magicseaweed.com/Surf-Report/#{@location_id}/")
    Nokogiri::HTML(doc)
  end
end
