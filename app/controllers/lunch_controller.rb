class LunchController < ApplicationController
  def feed
    @lunch = Lunch.new
    @restaurants = @lunch.einstein
    @restaurants.sort_by!{|r| r[:name]}
    @chalmers_restaurants = @lunch.chalmrest
    @chalmers_restaurants.sort_by!{|r| r[:name]}

    render partial: "feed"
  end
end
