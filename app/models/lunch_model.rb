class LunchModel
  include Feedjira

  date = Time.new.strftime("%Y-%m-%d")
  @@restaurants = {"Linsen" => "http://cm.lskitchen.se/johanneberg/linsen/sv/#{date}.rss",
    "Kårrestaurangen" => "http://cm.lskitchen.se/johanneberg/karrestaurangen/sv/#{date}.rss",
    "L's kitchen" => "http://cm.lskitchen.se/lindholmen/foodcourt/sv/#{date}.rss"}

  def restaurants
    @@restaurants.map do |key, url|
      meals = Feed.fetch_and_parse(url).entries.map do |entry|
        summary, price = entry.summary.split('@')
        { title: entry.title, summary: summary, price: price.try(&:to_i) }
      end

      { name: key, meals: meals }
    end
  end
end
