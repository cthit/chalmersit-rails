class BannersController < ApplicationController
  before_action :set_banner, only: [:show, :edit, :update, :destroy]
  before_action :authorize_banner, except: [:index, :create, :new]

  def index
    @banners = policy_scope(Banner)
    authorize @banners
  end
  def show
  end
  def edit
  end
  def new
    @banner = Banner.new
    authorize_banner
  end
  def create
    @banner = Banner.new(banner_params)
    authorize_banner
    respond_to do |format|
      if @banner.save
        format.html {
          render :crop
          #redirect_to @banner, notice: I18n.translate('model_created', name: 'banner')
        }
        format.json { render :show, status: :created, location: @banner }
      else
        p @banner.errors
        format.html { render :new }
        format.json { render json: @banner.errors, status: :unprocessable_entity }
      end
    end
  end
  def destroy
    @banner.destroy
    respond_to do |format|
      format.html { redirect_to banners_url, notice: I18n.translate('model_destroyed', name: @banner.model_name.human) }
      format.json { head :no_content }
    end
  end
  def update
    respond_to do |format|
      if @banner.update(banner_params)
        format.html { redirect_to @banner, notice: I18n.translate('model_updated', name: @banner.model_name.human) }
        format.json { render :show, status: :ok, location: @banner }
      else
        format.html { render :edit }
        format.json { render json: @banner.errors, status: :unprocessable_entity }
      end
    end
  end
private
  def set_banner
    @banner = Banner.find(params[:id])
  end
  def authorize_banner
    authorize @banner
  end
  def banner_params
    params.require(:banner).permit([:image_crop_x, :image_crop_y, :image_crop_w, :image_crop_h, :image, :group_id])
  end
end
