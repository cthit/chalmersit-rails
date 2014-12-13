class LunchController < ApplicationController
  def feed
    @lunch = LunchModel.new params[:restaurant]
  end
end
