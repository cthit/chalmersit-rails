class PrintController < ApplicationController
  def new
    @permitted_mime_types = %w(text/plain application/pdf)
    @available_ppi = %w(auto 600 1200)
  end
end
