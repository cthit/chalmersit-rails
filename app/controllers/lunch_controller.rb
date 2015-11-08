class LunchController < ApplicationController
  def feed
    @lunch = LunchModel.new
    @restaurants = @lunch.chalmrest
    @restaurants.sort_by!{|r| r[:name]}

    render partial: "feed"
  end
end
