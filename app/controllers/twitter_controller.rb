class TwitterController < ApplicationController
  def feed
    handle = twitter_params[:twitter_handle]
    options = twitter_params.except(:twitter_handle)
    render partial: 'twitter/feed', locals: { twitter_handle: handle, options: options }
  end


  def twitter_params
    params.permit(:count, :twitter_handle)
  end
end
