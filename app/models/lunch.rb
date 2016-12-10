class Lunch
  class << self
    include Feedjira
    include Nokogiri
    include OpenURI

    def cache_key
      "lunch/#{I18n.locale}/#{Date.today}"
    end

    def cache_present?
      Rails.cache.exist? self
    end

    def today_cached
      Rails.cache.fetch self do
        [Lunch.einstein, Lunch.chalmrest]
      end
    end

    def einstein
      url = "http://butlercatering.se/print/6"
      rest_name = 'Einstein'
      rest_name = 'Einstein 🍨' if Date.today.friday?
      begin
        menu = Nokogiri.HTML(open(url))
        price = 80
        week = menu.css('h2.lunch-titel').first.content.scan(/\d/).join('').to_i
        meals = menu.css('div.field-day').select{|day| valid_date?(week, day) }.flat_map do |day|
          day.css('p').to_a.reject{|m| invalid_meal?(m) }.map do |meal|
            content = meal.content.gsub(/[\s\u00A0]/, ' ').strip
            { title: '', summary: content, price: price } unless content.empty?
          end.compact
        end
        [{ name: rest_name, meals: meals }]
      rescue
        [{ name: rest_name, meals: {}}]
      end.sort_by { |r| r[:name] }
    end

    def chalmrest
      date = Time.new.strftime("%Y-%m-%d")
      locale = I18n.locale.to_s
      restaurants = {
        "Linsen"            => "http://intern.chalmerskonferens.se/view/restaurant/linsen/RSS%20Feed.rss?today=true&locale=#{locale}",
        "Kårrestaurangen"   => "http://intern.chalmerskonferens.se/view/restaurant/karrestaurangen/Veckomeny.rss?today=true&locale=#{locale}",
        "L's kitchen"       => "http://intern.chalmerskonferens.se/view/restaurant/l-s-kitchen/Projektor.rss?today=true&locale=#{locale}",
        "Express"           => "http://intern.chalmerskonferens.se/view/restaurant/express/V%C3%A4nster.rss?today=true&locale=#{locale}",
        #"J.A Pripps"        => "http://intern.chalmerskonferens.se/view/restaurant/j-a-pripps-pub-cafe/RSS%20Feed.rss?today=true&locale=#{locale}",
        #"Restaurang Hyllan" => "http://intern.chalmerskonferens.se/view/restaurant/hyllan/RSS%20Feed.rss?today=true&locale=#{locale}",
        "L's Resto"         => "http://intern.chalmerskonferens.se/view/restaurant/l-s-resto/RSS%20Feed.rss?today=true&locale=#{locale}",
        "Kokboken"          => "http://intern.chalmerskonferens.se/view/restaurant/kokboken/RSS%20Feed.rss?today=true&locale=#{locale}"}

      restaurants.map do |key, url|
        meals = Feed.fetch_and_parse(url).entries.map do |entry|
          summary, price = entry.summary.split('@')
          summary = summary.strip
          price = price.strip

          unless summary.empty?
            { title: entry.title, summary: summary, price: price.try(&:to_i) }
          end
        end.compact

        unless meals.empty?
          { name: key, meals: meals }
        end
      end.compact.sort_by { |r| r[:name] }
    end

    private

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

  end
end
