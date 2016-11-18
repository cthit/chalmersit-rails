class CoursesController < ApplicationController
  before_action :set_course, only: [:show, :edit, :update, :destroy, :site]
  before_action :authorize_course, except: [:index, :create, :new, :site]
  layout 'bare', only: [:index, :show]


  # GET /courses
  # GET /courses.json
  def index
    @courses = Course.all
  end

  # GET /courses/1
  # GET /courses/1.json
  def show
    if request.path != course_path(@course)
      redirect_to @course, status: :moved_permanently
    end
  end

  # GET /courses/new
  def new
    @course = Course.new
    authorize_course
  end

  # GET /courses/1/edit
  def edit
  end

  # POST /courses
  # POST /courses.json
  def create
    @course = Course.new(course_params)
    authorize_course

    respond_to do |format|
      if @course.save
        format.html { redirect_to @course, notice: I18n.translate('model_created', name:@course.name) }
        format.json { render :show, status: :created, location: @course }
      else
        format.html { render :new }
        format.json { render json: @course.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /courses/1
  # PATCH/PUT /courses/1.json
  def update
    respond_to do |format|
      if @course.update(course_params)
        format.html { redirect_to @course, notice: I18n.translate('model_updated', name: @course.name) }
        format.json { render :show, status: :ok, location: @course }
      else
        format.html { render :edit }
        format.json { render json: @course.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /courses/1
  # DELETE /courses/1.json
  def destroy
    @course.destroy
    respond_to do |format|
      format.html { redirect_to courses_url, notice: I18n.translate('model_destroyed', name:@course.name) }
      format.json { head :no_content }
    end
  end

  def site
    redirect_to @course.homepage
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_course
      @course = Course.find_by(code: params[:id])
    end

    def authorize_course
      authorize @course
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def course_params
      permitted = [:code, :name, :year, :required,{period_ids: []}, :homepage, :programme, :description] + Course.globalize_attribute_names
      params.require(:course).permit(permitted)
    end
end
