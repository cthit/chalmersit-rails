class LunchController < ApplicationController
  def feed
    @lunch = Lunch.new
    @restaurants = @lunch.einstein
    @chalmers_restaurants = @lunch.chalmrest

    render partial: "feed"
  end
end
