class TwitterController < ApplicationController
  def feed
  	options = params.permit(:count)
    render partial: 'twitter/feed', locals: { twitter_handle: params[:twitter_handle], options: options }
  end
end
