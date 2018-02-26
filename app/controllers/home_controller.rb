class HomeController < ApplicationController

  def index
    @posts = policy_scope(Post).ordered.limit(10)
    @events = Event.today

    if Lunch.cache_present?
      @restaurants = Lunch.today_cached
    end

    @calendar = Calendar.new
  end

  def card_balance
    url = Rails.configuration.card_balance_chalmers_it
    begin
      @balance, @name, @number = Rails.cache.fetch("card_balance/#{card_balance_params[:number]}", expires_in: 30.minutes) do
        j = JSON.parse(Net::HTTP.get(URI("#{url}/?number=#{card_balance_params[:number]}")))
        raise j["error"] if j.key?("error")
        [j["balance"], j["name"], j["number"]]
      end
      render partial: "card_balance"
    rescue => e
      render json: {error: e}, status: :bad_request
    end
  end

  private
  def card_balance_params
    params.permit(:number)
  end

end
