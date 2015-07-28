class SearchController < ApplicationController
  def index
    search = params[:search]
    @posts = Post.with_translations(I18n.locale).where('post_translations.title LIKE ? or post_translations.body LIKE ?', "%#{search}%", "%#{search}%") 

  end
end
