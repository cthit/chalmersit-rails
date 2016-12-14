class LunchController < ApplicationController
  before_action :detect_curl
  layout false

  def feed
    @restaurants, @chalmers_restaurants = Lunch.today_cached

    respond_to do |format|
      format.html
      format.html.terminal { render "feed.text.erb" }
      format.text
    end
  end
  private
    def detect_curl
      request.variant = :terminal if request.user_agent =~ /curl|libcurl/
    end
end
