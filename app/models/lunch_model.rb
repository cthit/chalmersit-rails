class LunchModel
  include Feedjira
  include Nokogiri
  include OpenURI

  def invalid_meal?(meal)
    desc = meal.content.gsub(/\s+\Z/, '')
    desc.length < 5 || desc.include?('dagens sallad')
  end

  def wday_to_date(year, week, day)
    days = %w(måndag tisdag onsdag torsdag fredag lördag söndag)
    Date.commercial(year, week, days.index(day) + 1)
  end

  def valid_date?(week, day_block)
    today = Date.today
    day = day_block.css('h3.field-label').first.content.downcase
    date = wday_to_date(today.year, week, day)
    date == today
  end

  def einstein
    # url = "http://butlercatering.se/einstein"
    url = "http://butlercatering.se/print/6"

    menu = Nokogiri.HTML(open(url))
    price = 80
    week = menu.css('h2.lunch-titel').first.content.scan(/\d/).join('').to_i
    meals = menu.css('div.field-day').select{|day| valid_date?(week, day) }.map do |day|
      day.css('p').to_a.reject{|m| invalid_meal?(m) }.map do |meal|
        content = meal.content.gsub(/\s+\Z/, '')
        { title: 'Einstein food', summary: content, price: price }
      end
    end
    [{ name: 'Einstein', meals: meals }]
  end

  def chalmrest
    date = Time.new.strftime("%Y-%m-%d")
    restaurants = {
      "Linsen"          => "http://cm.lskitchen.se/johanneberg/linsen/sv/#{date}.rss",
      "Kårrestaurangen" => "http://cm.lskitchen.se/johanneberg/karrestaurangen/sv/#{date}.rss",
      "L's kitchen"     => "http://cm.lskitchen.se/lindholmen/foodcourt/sv/#{date}.rss"}
    restaurants.map do |key, url|
      meals = Feed.fetch_and_parse(url).entries.map do |entry|
        summary, price = entry.summary.split('@')
        { title: entry.title, summary: summary, price: price.try(&:to_i) }
      end
      { name: key, meals: meals }
    end
  end
end
