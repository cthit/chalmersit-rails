class CommitteesController < ApplicationController
  before_action :set_committee, only: [:show, :edit, :update, :destroy]
  before_action :authorize_committee, except: [:index, :create, :new]

  # GET /committees
  # GET /committees.json
  def index
    # Committees are loaded in ApplicationController
    redirect_to '/committees/styrit'
  end

  # GET /committees/1
  # GET /committees/1.json
  def show
    @pages = Page.all
  end

  # GET /committees/new
  def new
    @committee = Committee.new
    authorize_committee
  end

  # GET /committees/1/edit
  def edit
  end

  # POST /committees
  # POST /committees.json
  def create
    @committee = Committee.new(committee_params)
    authorize_committee

    respond_to do |format|
      if @committee.save
        format.html { redirect_to @committee, notice: I18n.translate('model_created', name:@committee.name) }
        format.json { render :show, status: :created, location: @committee }
      else
        format.html { render :new }
        format.json { render json: @committee.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /committees/1
  # PATCH/PUT /committees/1.json
  def update
    respond_to do |format|
      if @committee.update(committee_params)
        format.html { redirect_to @committee, notice: I18n.translate('model_updated', name:@committee.name) }
        format.json { render :show, status: :ok, location: @committee }
      else
        format.html { render :edit }
        format.json { render json: @committee.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /committees/1
  # DELETE /committees/1.json
  def destroy
    @committee.destroy
    respond_to do |format|
      format.html { redirect_to committees_url, notice: I18n.translate('model_destroyed', name:@committee.name)}
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_committee
      @committee = Committee.find_by(slug: params[:id])
      @committee.positions
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def committee_params
      permitted = [:slug, :name, :url, :email] + Committee.globalize_attribute_names
      params.require(:committee).permit(permitted)
    end

    def authorize_committee
      authorize @committee
    end
end
