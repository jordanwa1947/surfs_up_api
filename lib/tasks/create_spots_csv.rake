desc 'Scrape spots And create A CSV with them'
task :create_spots_csv => :environment do
    scraper = MswSpotScraper.new
    scraper.loop_through_ids('csv')
end
