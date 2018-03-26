class Lunch
  class << self
    include OpenURI
    include JSON

    def cache_key
      "lunch/#{I18n.locale}/#{Date.today}"
    end

    def cache_present?
      Rails.cache.exist? self
    end

    def today_cached
      Rails.cache.fetch self, expires_in: 1.hour do
        Lunch.fetch_from_api
      end
    rescue
      nil
    end

    def fetch_from_api
      url = "https://lunch.chalmers.it"
      JSON.parse(open(url).read)
    end
  end
end
