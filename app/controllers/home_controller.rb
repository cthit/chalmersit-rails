class HomeController < ApplicationController

  def index
    @posts = policy_scope(Post).ordered.limit(10)
    @events = Event.today

    if Lunch.cache_present?
      @restaurants = Lunch.today_cached
    end

    @calendar = Calendar.new
  end

end
