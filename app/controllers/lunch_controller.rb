class LunchController < ApplicationController
  before_action :detect_curl
  layout false

  def feed
    @restaurants = Lunch.today_cached

    respond_to do |format|
      format.html
      format.html.terminal {
        render "feed.text.erb"
      }
      format.text
    end
  end
  private
    def detect_curl
      request.variant = :terminal if request.user_agent =~ /curl/
    end
    def analyse_filter(filter)
      if filter =~ /lindholmen|johanneberg/
        :location
      else
        :fuzzy
      end
    end
    def restaurants_in(location, restaurants)
      restaurants.select do |rest|
        rest[:location].nil? || rest[:location].downcase == location
      end
    end
    def filter_restaurants(filter, restaurants)
      restaurants.select do |rest|
        rest[:name].downcase.include? filter
      end
    end
end
