class FrontpageController < ApplicationController
  layout 'bare'

  def update
     @frontpage = Frontpage.first
     @frontpage.update(frontpage_params)
     
     @pages = Page.all
     render :edit
  end

  def edit
    @frontpage = Frontpage.first
    @pages = Page.all
  end

  private

    def frontpage_params
      params.require(:frontpage).permit([:page_id])
    end

end
