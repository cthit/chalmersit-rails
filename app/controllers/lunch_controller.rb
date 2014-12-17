class LunchController < ApplicationController
  def feed
    @lunch = LunchModel.new
  end
end
