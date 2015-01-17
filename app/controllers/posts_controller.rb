class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  before_action :find_or_create_event, only: [:new, :edit]

  # GET /posts
  # GET /posts.json
  def index
    @posts = Post.all.ordered
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
    @comments = @post.comments.order(created_at: :desc)
    @comment = Comment.new
    if request.path != post_path(@post)
      redirect_to @post, status: :moved_permanently
    end
  end

  # GET /posts/new
  def new
    @post = Post.new
  end

  # GET /posts/1/edit
  def edit
  end

  # POST /posts
  # POST /posts.json
  def create
    pp = set_destroy
    pp.merge!(user_id: current_user.uid)
    @post = Post.new(pp)

    respond_to do |format|
      if @post.save
        format.html { redirect_to @post, notice: I18n.translate('model_created', name:@post.title) }
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
    pp = set_destroy
    pp.merge!(user_id: current_user.uid)

    respond_to do |format|
      if @post.update(pp)
        format.html { redirect_to @post, notice: I18n.translate('model_updated', name:@post.title) }
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
      format.html { redirect_to posts_url, notice: I18n.translate('model_destroyed', name:@post.title) }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find params[:id].split('-')[0]
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      permitted = [:group_id, :title, :body, :sticky, { event_attributes: [:event_date, :full_day, :start_time, :end_time, :facebook_link, :location, :organizer, :id] }] + Post.globalize_attribute_names
      params.require(:post).permit(permitted)
    end

    def find_or_create_event
      @event ||= begin
        return @post.event unless @post.nil? || @post.event.nil?
        Event.new(post: @post, event_date: Date.today, start_time: Time.now.strftime('%R'), end_time: (Time.now + 1.hour).strftime('%R'))
      end
    end

    def set_destroy
      pp = post_params
      pp[:event_attributes][:_destroy] = 1 unless params[:post_is_event]
      pp
    end
end
