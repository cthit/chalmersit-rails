class PagesController < ApplicationController
  before_action :set_page, only: [:edit, :update, :destroy, :delete_document]

  # GET /pages
  # GET /pages.json
  def index
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
    @other_pages = Page.order(:title)
  end

  # GET /pages/1/edit
  def edit
    @other_pages = Page.order(:title).where("id != ?", @page.id)
  end

  # POST /pages
  # POST /pages.json
  def create
    unless params[:document].nil?
      params[:document].each do |doc|
        params[:page][:documents].push(doc)
      end
    end
    @page = Page.new(page_params)

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
    unless params[:page][:documents].nil?
      documents = @page.documents
      documents += params[:page][:documents]
      params[:page][:documents] = ""
      @page.documents = documents
    end
    respond_to do |format|
      if @page.update(page_params)
        format.html { redirect_to @page, notice: 'Page was successfully updated.' }
        format.json { render :show, status: :ok, location: @page }
      else
        format.html { render :edit }
        format.json { render json: @page.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pages/1
  # DELETE /pages/1.json
  def destroy
    @page.destroy
    respond_to do |format|
      format.html { redirect_to pages_url, notice: 'Page was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
  def delete_document
    remain_documents = []
    @page.documents.each do |doc|
      puts "checking: " + doc.path
      unless File.basename(doc.path, ".*") == params[:document_name]
        remain_documents.push(doc)
        puts "adding: " + doc.path
      end
    end
    if remain_documents.empty?
      @page.remove_documents = true
    else
      @page.documents = remain_documents # re-assign back
    end
    if @page.save
      redirect_to edit_page_url(@page), notice: 'Page was successfully updated.'
    else
      render :edit
    end
  end
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_page
      @page = Page.find_by(slug: params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def page_params
      permitted = [:title,:body,:parent_id, {documents: []}]
      params.require(:page).permit(permitted)
      #params.require(:title,:body).permit(:parent)
    end
end
