class Lunch
  class << self
    include Feedjira
    include Nokogiri
    include OpenURI

    ALLERGENS_IMAGES = {
      "egg-white.png" => "allergens.egg",
      "gluten-white.png" => "allergens.gluten",
      "lactose-white.png" => "allergens.lactose"
    }

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
        week = menu.css('h2.lunch-titel').first.content.scan(/\d/).join('').to_i
        meals = menu.css('div.field-day').select{|day| valid_date?(week, day) }.flat_map do |day|
          day.css('p').to_a.reject{|m| invalid_meal?(m) }.map do |meal|
            content = meal.content.gsub(/[\s\u00A0]/, ' ').strip
            unless content.empty?
              the_meal = tag_food(content)
              the_meal[:allergens] = " - N/A"
              the_meal
            end
          end.compact
        end
        unless meals.empty?
          [{ name: rest_name, meals: meals, location: "Johanneberg" }]
        else
          []
        end
      rescue
        []
      end
    end

    def chalmrest
      date = Time.new.strftime("%Y-%m-%d")
      locale = I18n.locale.to_s
      restaurants = [
        {name: "Linsen", url: "http://intern.chalmerskonferens.se/view/restaurant/linsen/RSS%20Feed.rss?today=true&locale=#{locale}", location: "Johanneberg"},
        {name: "Kårrestaurangen", url: "http://intern.chalmerskonferens.se/view/restaurant/karrestaurangen/Veckomeny.rss?today=true&locale=#{locale}", location: "Johanneberg"},
        {name: "L's kitchen", url: "http://intern.chalmerskonferens.se/view/restaurant/l-s-kitchen/Projektor.rss?today=true&locale=#{locale}", location: "Lindholmen"},
        {name: "Express", url: "http://intern.chalmerskonferens.se/view/restaurant/express/V%C3%A4nster.rss?today=true&locale=#{locale}", location: "Johanneberg"},
        #{name: "J.A Pripps", url: "http://intern.chalmerskonferens.se/view/restaurant/j-a-pripps-pub-cafe/RSS%20Feed.rss?today=true&locale=#{locale}", location: "Johanneberg"},
        #{name: "Restaurang Hyllan", url: "http://intern.chalmerskonferens.se/view/restaurant/hyllan/RSS%20Feed.rss?today=true&locale=#{locale}", location: "Johanneberg"},
        {name: "L's Resto", url: "http://intern.chalmerskonferens.se/view/restaurant/l-s-resto/RSS%20Feed.rss?today=true&locale=#{locale}", location: "Lindholmen"},
        {name: "Kokboken", url: "http://intern.chalmerskonferens.se/view/restaurant/kokboken/RSS%20Feed.rss?today=true&locale=#{locale}", location: "Lindholmen"}
      ]

      restaurants.map do |restaurant|
        meals = Feed.fetch_and_parse(restaurant[:url]).entries.map do |entry|
          summary, price = entry.summary.split('@')
          summary = summary.strip
          price = price.strip
          if restaurant[:name] == "Express" || restaurant[:name] == "Kårrestaurangen"
            allergens = get_allergens(entry)
          else
            allergens = " - N/A"
          end
          unless summary.empty?
            { title: entry.title, summary: summary, price: price.try(&:to_i), allergens: allergens }
          end
        end.compact

        unless meals.empty?
          { name: restaurant[:name], meals: meals, location: restaurant[:location] }
        end
      end.compact.sort_by { |r| r[:name] }
    end

    private

      def invalid_meal?(meal)
        desc = meal.content.gsub(/\s+\Z/, '')
        desc.length < 5 || desc.downcase =~ /dagens sallad|glassbuff[eé]|dagens asiatiska buffé/
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

      def tag_food(food)
        title = if food.downcase.start_with? 'veg:'
          food.gsub! 'Veg: ', ''
          "food.veg"
        elsif food.downcase =~ /fisk|torsk|spätta|skaldjur|lubb|kolja|lax/
          "food.fish"
        elsif food.downcase =~ /kött|fläsk|färs|karr[eé]|kyckling|rev|biff/
          "food.meat"
        else
          "food.default"
        end

        { title: I18n.t(title), summary: food, price: 85 }
      end

      def get_allergens(meal_entry)
        allergensArray = Array.new
        ALLERGENS_IMAGES.each do |image_name, allergen|
          allergensArray.push(I18n.t(allergen)) if meal_entry[:summary].include? image_name
        end
        " - " + allergensArray.join(", ") unless allergensArray.empty?
      end

  end
end
