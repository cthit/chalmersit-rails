class LunchModel
  include Feedjira

  date = Time.new.strftime("%Y-%m-%d")
  @@restaurants = {"Linsen" => "http://cm.lskitchen.se/johanneberg/linsen/sv/#{date}.rss",
    "Kårrestaurangen" => "http://cm.lskitchen.se/johanneberg/karrestaurangen/sv/#{date}.rss",
    "L's kitchen" => "http://cm.lskitchen.se/lindholmen/foodcourt/sv/#{date}.rss"}
  attr_reader :url, :restaurant

  def initialize(restaurant)
    @restaurant = restaurant
    @url = @@restaurants[@restaurant]
  end

  def feed_entries
    @entries ||= Feed.fetch_and_parse(@url).entries.map do |entry|
      {title: entry.title, summary: entry.summary.split("@")[0]}
    end
  end

  def available_restaurants
    available = []
    @@restaurants.each do |key, _|
      available.push key
    end
    available
  end
end
