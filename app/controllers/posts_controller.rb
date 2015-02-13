class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  layout 'bare', only: [:index, :show]
  before_action :authorize_post, except: [:index, :create, :new]

  # GET /posts
  # GET /posts.json
  def index
    @posts = policy_scope(Post).ordered
    @posts = @posts.where(user_id: params[:user]) if params[:user]
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
    @comments = @post.comments.latest_first
    @comment = @post.comments.build
    if request.path != post_path(@post)
      redirect_to @post, status: :moved_permanently
    end
  end

  # GET /posts/new
  def new
    @post = Post.new(show_public: true)
    authorize_post
    build_event
  end

  # GET /posts/1/edit
  def edit
    build_event unless @post.event
  end

  # POST /posts
  # POST /posts.json
  def create
    @post = current_user.posts.build(post_params)
    authorize_post

    respond_to do |format|
      if @post.save
        format.html { redirect_to @post, notice: I18n.translate('model_created', name: @post.title) }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
  def update
    @post.user_id = current_user.id

    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to @post, notice: I18n.translate('model_updated', name: @post.title) }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to posts_url, notice: I18n.translate('model_destroyed', name: @post.title) }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find params[:id].split('-').first
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      permitted = [:group_id, :title, :body, :sticky, :show_public, { event_attributes: [:event_date, :full_day, :start_time, :end_time, :facebook_link, :location, :_destroy, :organizer, :id] }] + Post.globalize_attribute_names
      params.require(:post).permit(permitted)
    end

    def build_event
      @post.build_event(event_date: Date.today, start_time: Time.now.strftime('%R'), end_time: 1.hour.from_now.strftime('%R'))
    end

    def authorize_post
      authorize @post
    end
end
