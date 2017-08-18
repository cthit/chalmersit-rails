class Lunch
  class << self
    include Feedjira
    include Nokogiri
    include OpenURI
    include JSON

    # Allergies supported in API
    noAllergens = 0
    gluten = 1
    lactose = 2
    egg = 3
    rennet = 4
    fish = 6

    ALLERGENS_IMAGES = {
      egg => "allergens.egg",
      gluten => "allergens.gluten",
      lactose => "allergens.lactose",
      rennet => "allergens.rennet"
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
              the_meal[:allergens] = nil
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
        {name: "Linsen", url: "http://carboncloudrestaurantapi.azurewebsites.net/api/menuscreen/getdataday?restaurantid=33", location: "Johanneberg"},
        {name: "Kårrestaurangen", url: "http://carboncloudrestaurantapi.azurewebsites.net/api/menuscreen/getdataday?restaurantid=5", location: "Johanneberg"},
        {name: "L's kitchen", url: "http://carboncloudrestaurantapi.azurewebsites.net/api/menuscreen/getdataday?restaurantid=8", location: "Lindholmen"},
        {name: "Express", url: "http://carboncloudrestaurantapi.azurewebsites.net/api/menuscreen/getdataday?restaurantid=9", location: "Johanneberg"},
        #{name: "J.A Pripps", url: "http://intern.chalmerskonferens.se/view/restaurant/j-a-pripps-pub-cafe/RSS%20Feed.rss?today=true&locale=#{locale}", location: "Johanneberg"},
        #{name: "Restaurang Hyllan", url: "http://intern.chalmerskonferens.se/view/restaurant/hyllan/RSS%20Feed.rss?today=true&locale=#{locale}", location: "Johanneberg"},
        {name: "L's Resto", url: "http://carboncloudrestaurantapi.azurewebsites.net/api/menuscreen/getdataday?restaurantid=32", location: "Lindholmen"},
        {name: "Kokboken", url: "http://carboncloudrestaurantapi.azurewebsites.net/api/menuscreen/getdataday?restaurantid=35", location: "Lindholmen"}
      ]

      restaurants.map do |restaurant|
        data = JSON.parse(open(restaurant[:url]).read)
        items = "recipeCategories"
        if data.key?(items) && data[items] != nil
          meals = data[items].map do |category|

            category["recipes"].map do |recipe|
              allergens = recipe["allergens"]
              summary = recipe["displayNames"].first["displayName"]
              if recipe["allergens"].first["id"] != nil
                allergens = get_allergens(recipe["allergens"])
              end
              unless summary.empty?
                { title: category["name"], summary: summary, price: recipe["price"], allergens: allergens }
              end
            end

          end.flatten.compact

          unless meals.empty?
            { name: restaurant[:name], meals: meals, location: restaurant[:location] }
          end
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

      def get_allergens(allergens_entry)
        tmp = []
        allergens_entry.map do |e|
          tmp.push(e["id"])
        end
        allergens_entry = tmp
        ALLERGENS_IMAGES.select do |image_name, allergen|
          allergens_entry.include? image_name
        end.map { |key, allergen| I18n.t(allergen) }
      end

  end
end
