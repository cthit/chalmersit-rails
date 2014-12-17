class LunchController < ApplicationController
  def feed
    @lunch = LunchModel.new
    render partial: 'feed'
  end
end
