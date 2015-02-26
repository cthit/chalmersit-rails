class KarkortController < ApplicationController
  include PhantomjsHelper
  def fetch
    # TODO caching for result
    render json: casper_run(:karkort, params[:card_number])
  end
end
