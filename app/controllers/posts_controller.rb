class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  layout 'bare', only: [:index, :show]
  before_action :authorize_post, except: [:index, :create, :new]
  after_action :post_event, only: [:create]
  # GET /posts
  # GET /posts.json
  def index
    @posts = policy_scope(Post).page(params[:page]).ordered
    @posts = @posts.where(user_id: params[:user]) if params[:user]
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
    @comments = @post.comments.latest_last

    if request.path != post_path(@post, format: request[:format])
      redirect_to post_path(@post, format: request[:format]), status: :moved_permanently
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
    
    unless @post.event.nil?
      unless @post.event.facebook_link.include?("http://") || @post.event.facebook_link.include?("https://") || @post.event.facebook_link.empty?
        @post.event.facebook_link.insert(0, "https://")
      end
    end
    authorize_post
    #Tries to save the post and gives the output in the requested format.
    respond_to do |format|
      if @post.save
        format.html { redirect_to @post, notice: I18n.translate('model_created', name: @post.title) }
        format.json { render :show, status: :created, location: @post }
      else
        p @post.errors
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
      permitted = [:group_id, :title, :body, :sticky, :show_public, :image_upload, { event_attributes: [:event_date, :full_day, :start_time, :end_time, :facebook_link, :location, :_destroy, :organizer, :id] }] + Post.globalize_attribute_names
      params.require(:post).permit(permitted)
    end

    def build_event
      @post.build_event(event_date: Date.today, start_time: Time.now.strftime('%R'), end_time: 1.hour.from_now.strftime('%R'))
    end

    def authorize_post
      authorize @post
    end

    def post_event
      if @post.valid?
        if Rails.env.production?
          begin
            send_slack
          rescue Exception => e
            logger.error e.message
            e.backtrace.each { |line| logger.error line }
          end
        end
      end
    end

    def send_slack
      cthit_notifier = Slack::Notifier.new Rails.application.secrets.slack_url
      cthit_notifier.post unfurl_links: true, unfurl_media: true, text: "New post published: *[#{@post.title_sv}](#{post_url(@post, locale: 'sv')})* by #{@post.user.display_name}"
      mrcit_notifier = cthit_notifier = Slack::Notifier.new Rails.application.secrets.mrcit_slack_url
      mrcit_notifier.post unfurl_links: true, unfurl_media: true, text: "New post published: *[#{@post.title_sv}](#{post_url(@post, locale: 'en')})* by #{@post.user.display_name}"
    end
end
