class HomeController < ApplicationController

  def index
    @posts = Post.all.ordered.limit(10)
    @events = Event.today
  end
end
