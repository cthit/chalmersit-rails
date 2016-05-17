class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy, :delete_document]
  layout 'bare', only: [:index, :show]
  before_action :authorize_post, except: [:index, :create, :new]
#  after_action :send_mail, only:[:update, :create]
  # GET /posts
  # GET /posts.json
  def index
    @posts = policy_scope(Post).ordered
    @posts = @posts.where(user_id: params[:user]) if params[:user]
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
    @comments = @post.comments.latest_last
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
    unless params[:document].nil?
      params[:document].each do |doc|
        params[:post][:documents].push(doc)
      end
    end
    @post = current_user.posts.build(post_params)
    @post.image = post_params[:image_upload]

    authorize_post

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
  def delete_document
    remain_documents = []
    @post.documents.each do |doc|
      puts "checking: " + doc.path
      unless File.basename(doc.path, ".*") == params[:document_name]
        remain_documents.push(doc)
        puts "adding: " + doc.path
      end
    end
    if remain_documents.empty?
      @post.remove_documents = true
    else
      @post.documents = remain_documents # re-assign back
    end
    if @post.save
      redirect_to edit_post_url(@post), notice: 'Post was successfully updated.'
    else
      render :edit
    end
  end

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
  def update
    unless params[:post][:documents].nil?
      documents = @post.documents
      documents += params[:post][:documents]
      params[:post][:documents] = ""
      @post.documents = documents
    end
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
      permitted = [:group_id, :title, :body, :sticky, :show_public, :image_upload, {documents: []}, { event_attributes: [:event_date, :full_day, :start_time, :end_time, :facebook_link, :location, :_destroy, :organizer, :id] }] + Post.globalize_attribute_names
      params.require(:post).permit(permitted)
    end

    def build_event
      @post.build_event(event_date: Date.today, start_time: Time.now.strftime('%R'), end_time: 1.hour.from_now.strftime('%R'))
    end

    def authorize_post
      authorize @post
    end


    def send_mail
  		pathPushMail = '/applications/push-to-subscribers/1'
		link = Rails.application.config.account_ip + pathPushMail
		url = URI.parse(link)
		http = Net::HTTP.new(url.host, url.port)
		http.use_ssl = true
		req = Net::HTTP::Get.new(url.path)
		req.add_field('Authorization', 'Token token=' + Rails.application.secrets.push_mail_token)
		req.add_field('push_message', @post.body)
		req.add_field('push_title', @post.title)
		req.add_field('push_url',post_url(@post))
		req.add_field('push_url_title', @post.title)
		response = http.request(req)
   	end


end
