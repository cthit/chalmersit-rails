class DocumentsController < ApplicationController
  before_filter :set_document, only: :destroy

  def create
    @document = Document.new(document_params)

    if @document.save
      render json: @document, location: @document
    else
      render json: @document.errors, status: :unprocessable_entity
    end
  end

  def destroy

  end

  private
    def set_document
      @document = Document.find(params[:id]) if params[:id]
    end

    def document_params
      params.require(:document).permit(:document, :user_id)
    end
end
