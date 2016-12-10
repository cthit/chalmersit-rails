class FrontpageController < ApplicationController
  layout 'bare'

  def update
     @frontpage = Frontpage.first
     @frontpage.update(frontpage_params)

     @pages = Page.all
     render :edit
     authorize_frontpage
  end

  def edit
    @frontpage = Frontpage.first
    @pages = Page.all
    authorize_frontpage
  end

  private

    def frontpage_params
      params.require(:frontpage).permit([:page_id])
    end

    def authorize_frontpage
      authorize @frontpage
    end

end
