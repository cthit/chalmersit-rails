class HomeController < ApplicationController
  layout 'home'

  def index
    @posts = Post.all.ordered.limit(10)
  end
end
