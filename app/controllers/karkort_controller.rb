class KarkortController < ApplicationController
  include KarkortHelper
  def fetch
    # TODO caching for result
    @card = current_user.card
    authorize @card
    render json: balance(@card)
  end
end
