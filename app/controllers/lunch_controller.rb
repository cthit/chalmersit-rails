class LunchController < ApplicationController
  layout false

  def feed
    @restaurants, @chalmers_restaurants = Lunch.today_cached
  end
end
