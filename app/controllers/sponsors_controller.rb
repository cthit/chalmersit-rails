class SponsorsController < ApplicationController
  before_action :set_sponsor, only: [:update, :edit, :show, :destroy]
  def index
    @sponsors = Sponsor.all
  end
  def show
  end
  def new
    @sponsor = Sponsor.new
  end
  def create
    @sponsor = Sponsor.new(sponsor_params)
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
    params.require(:sponsor).permit(:name, :image)
  end
  def set_sponsor
    @sponsor = Sponsor.find(params[:id])
  end
end
