class HomeController < ApplicationController

  def index
    @posts = policy_scope(Post).ordered.limit(10)
    @events = Event.today
  end

  def card_balance
    @balance = StudentUnionCardBalance.new.student_union_card_balance(card_balance_params[:number])
    render partial: "card_balance"
  end

  private
  def card_balance_params
    params.permit(:number)
  end

end
