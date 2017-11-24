class SearchController < ApplicationController
  before_action :set_search

  def index
    if @search
      posts_query = 'post_translations.title LIKE ? or post_translations.body LIKE ?'
      @posts = Post.with_translations(I18n.locale).where(posts_query, "%#{@search}%", "%#{@search}%").ordered
      @posts = @posts.only_public unless signed_in?
    else
      @posts = []
    end
  end

  private
    def set_search
      @search = params[:search]
    end
end
