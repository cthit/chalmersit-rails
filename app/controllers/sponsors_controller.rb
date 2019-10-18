class SponsorsController < ApplicationController
  before_action :set_sponsor, only: [:update, :edit, :show, :destroy]
  before_action :authorize_sponsor, except: [:index, :new, :create]

  def index
    @sponsors = Sponsor.all
    authorize @sponsors
  end
  def show
  end
  def new
    @sponsor = Sponsor.new
    authorize_sponsor
  end
  def create
    @sponsor = Sponsor.new(sponsor_params)
    authorize_sponsor
    if @sponsor.save
      redirect_to sponsor_path(@sponsor)
    else
      render :new
    end
  end
  def edit
  end
  def update
    if @sponsor.update(sponsor_params)
      redirect_to sponsor_path(@sponsor)
    else
      render :new
    end
  end
  def destroy
    @sponsor.destroy
    redirect_to sponsors_path
  end

private
  def sponsor_params
    permitted = [:name, :image, :order, :imagelink] + Sponsor.globalize_attribute_names
    params.require(:sponsor).permit(permitted)
  end
  def set_sponsor
    @sponsor = Sponsor.find(params[:id])
  end
  def authorize_sponsor
    authorize @sponsor
  end
end
