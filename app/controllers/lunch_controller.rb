class LunchController < ApplicationController
  def feed
    @restaurants, @chalmers_restaurants = Rails.cache.fetch("lunch/#{I18n.locale}/#{Date.today}") do
      @lunch = Lunch.new
      [@lunch.einstein, @lunch.chalmrest]
    end

    render partial: "feed"
  end
end
