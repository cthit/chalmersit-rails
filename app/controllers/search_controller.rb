class SearchController < ApplicationController
  before_action :set_search

  def index
    if @search
      posts_query = 'post_translations.title LIKE ? or post_translations.body LIKE ?'
      @posts = policy_scope(Post).with_translations(I18n.locale).where(posts_query, "%#{@search}%", "%#{@search}%").ordered
    else
      @posts = []
    end
  end

  private
    def set_search
      @search = params[:search]
    end
end
