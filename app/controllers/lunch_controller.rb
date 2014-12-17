class LunchController < ApplicationController
  def feed
    @lunch = LunchModel.new
    render partial: 'feed.html'
  end
end
