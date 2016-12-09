class HomeController < ApplicationController

  def index
    @posts = policy_scope(Post).ordered.limit(10)
    @events = Event.today
  end

  def card_balance
    begin
      @balance, @name = Rails.cache.fetch("card_balance/#{card_balance_params[:number]}", expires_in: 30.minutes) do
        StudentUnionCardBalance.new.student_union_card_balance(card_balance_params[:number])
      end
      render partial: "card_balance"
    rescue
      render json: {error: "Bad number"}, status: :bad_request
    end
  end

  private
  def card_balance_params
    params.permit(:number)
  end

end
