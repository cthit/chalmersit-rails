class BusinessController < ApplicationController
  def index
    @pages = Page.all
    @page = Page.find_by(slug: "business")
    render 'pages/show', id: "business"
  end
end
