class HomeController < ApplicationController
  layout 'home'

  def index
    @posts = Post.all.order(created_at: :desc).limit(10)
  end
end
