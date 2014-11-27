class TwitterController < ApplicationController
  def feed
    render partial: 'twitter/feed', locals: { twitter_handle: params[:twitter_handle] }
  end
end
