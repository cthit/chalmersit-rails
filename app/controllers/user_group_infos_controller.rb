class UserGroupInfosController < ApplicationController
  before_action :set_user_group_info, only: [:show, :edit, :update, :destroy]
  before_action :authorize_user_group_info, except: [:index, :create, :new]
  # GET /user_group_infos
  # GET /user_group_infos.json
  def index
    @user_group_infos = UserGroupInfo.all
  end

  # GET /user_group_infos/1
  # GET /user_group_infos/1.json
  def show
  end

  # GET /user_group_infos/new
  def new
    @user_group_info = UserGroupInfo.new
    authorize_user_group_info
  end

  # GET /user_group_infos/1/edit
  def edit
  end

  # POST /user_group_infos
  # POST /user_group_infos.json
  def create
    @user_group_info = UserGroupInfo.new(user_group_info_params)
    authorize_user_group_info
    respond_to do |format|
      if @user_group_info.save
        format.html { redirect_to @user_group_info, notice: 'User group info was successfully created.' }
        format.json { render :show, status: :created, location: @user_group_info }
      else
        format.html { render :new }
        format.json { render json: @user_group_info.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /user_group_infos/1
  # PATCH/PUT /user_group_infos/1.json
  def update
    respond_to do |format|
      if @user_group_info.update(user_group_info_params)
        format.html { redirect_to @user_group_info, notice: 'User group info was successfully updated.' }
        format.json { render :show, status: :ok, location: @user_group_info }
      else
        format.html { render :edit }
        format.json { render json: @user_group_info.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /user_group_infos/1
  # DELETE /user_group_infos/1.json
  def destroy
    @user_group_info.destroy
    respond_to do |format|
      format.html { redirect_to user_group_infos_url, notice: 'User group info was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user_group_info
      @user_group_info = UserGroupInfo.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_group_info_params
      permitted = [:user_id, :group_id] + UserGroupInfo.globalize_attribute_names
      params.require(:user_group_info).permit(permitted)
    end

    def authorize_user_group_info
      authorize @user_group_info
    end
end
