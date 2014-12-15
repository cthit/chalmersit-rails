class ImagesController < ApplicationController
  before_filter :set_image, only: :destroy

  def create
    @image = Image.new(image_params)

    if @image.save
      render json: @image, location: @image
    else
      render json: @image.errors, status: :unprocessable_entity
    end
  end

  def destroy

  end

  private
    def set_image
      @image = Image.find(params[:id]) if params[:id]
    end

    def image_params
      params.require(:image).permit(:source, :user_id)
    end
end
