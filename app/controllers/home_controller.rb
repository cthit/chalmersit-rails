class HomeController < ApplicationController
  layout 'home'

  def index
    @posts = Post.all.limit(10)
  end
end
