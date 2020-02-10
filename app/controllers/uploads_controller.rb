class UploadsController < ApplicationController
  before_action :set_upload, only: :destroy

  def create
    @upload = Upload.new(upload_params)

    if @upload.save
      render json: @upload, location: @upload
    else
      render json: @upload.errors, status: :unprocessable_entity
    end
  end

  def destroy

  end

  private
    def set_upload
      @upload = Upload.find(params[:id]) if params[:id]
    end

    def upload_params
      params.require(:upload).permit(:source, :user_id)
    end
end
