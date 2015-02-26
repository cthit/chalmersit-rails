class KarkortController < ApplicationController
  include KarkortHelper
  def fetch
    # TODO caching for result
    render json: balance(params[:card_number])
  end
end
