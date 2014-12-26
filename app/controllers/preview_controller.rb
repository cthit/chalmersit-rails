class PreviewController < ApplicationController
  include ApplicationHelper

  def preview
    @text = params[:text]
    render html: markdown(@text)
  end
end
