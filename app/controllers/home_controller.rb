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
    uri = URI(Rails.configuration.card_balance_chalmers_it)
    params = {number: card_balance_params[:number]}
    uri.query = URI.encode_www_form(params)
    begin
      @balance, @name, @number = Rails.cache.fetch("card_balance/#{card_balance_params[:number]}", expires_in: 30.minutes) do
        response = Net::HTTP.get_response(uri)
        j = JSON.parse(response.body)

        raise j["error"] if not response.is_a?(Net::HTTPSuccess)

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
