class PagesController < ApplicationController
  before_action :set_page, only: [:edit, :update, :destroy]

  # GET /pages
  # GET /pages.json
  def index
    @frontpage = Page.find(Frontpage.first.page_id)
    @pages = Page.all
  end

  # GET /pages/1
  # GET /pages/1.json
  def show
    if params[:id]
      @page = Page.find_by(slug: params[:id])
    else
      @page = Page.find_by!(slug: params[:path].split('/').last)
    end
    @pages = Page.all
    @committees = Committee.all
  end

  # GET /pages/new
  def new
    @page = Page.new
    authorize @page
    @other_pages = Page.all
  end

  # GET /pages/1/edit
  def edit
    @other_pages = Page.where("id != ?", @page.id)
  end

  # POST /pages
  # POST /pages.json
  def create
    @page = Page.new(page_params)
    authorize @page

    respond_to do |format|
      if @page.save
        format.html { redirect_to @page, notice: 'Page was successfully created.' }
        format.json { render :show, status: :created, location: @page }
      else
        format.html { render :new }
        format.json { render json: @page.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /pages/1
  # PATCH/PUT /pages/1.json
  def update
    authorize @page
    respond_to do |format|
      if @page.update(page_params)
        format.html { redirect_to @page, notice: 'Page was successfully updated.' }
        format.json { render :show, status: :ok, location: @page }
      else
        @other_pages = Page.where("id != ?", @page.id)
        format.html { render :edit }
        format.json { render json: @page.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pages/1
  # DELETE /pages/1.json
  def destroy
    authorize @page
    @page.destroy
    respond_to do |format|
      format.html { redirect_to pages_url, notice: 'Page was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_page
      @page = Page.find_by(slug: params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def page_params
      permitted = [:parent_id] + Page.globalize_attribute_names
      params.require(:page).permit(permitted)
      #params.require(:title,:body).permit(:parent)
    end
end
