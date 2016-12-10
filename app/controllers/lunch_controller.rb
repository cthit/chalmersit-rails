class LunchController < ApplicationController
  def feed
    @restaurants, @chalmers_restaurants = Lunch.today_cached
    render partial: "feed"
  end
end
