class CommentsController < ApplicationController
  before_action :set_comment, only: :destroy

  # POST /comments
  # POST /comments.json
  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.build(comment_params)
    @comment.user = current_user

    authorize @comment
    respond_to do |format|
      if @comment.save
        format.html { redirect_to post_path(@post, anchor: 'comments'), notice: I18n.translate('model_created', name:I18n.translate('comment_definite')) }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render 'posts/show', location: @post }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /comments/1
  # DELETE /comments/1.json
  def destroy
    @post = @comment.post
    authorize @comment
    @comment.destroy
    respond_to do |format|
      format.html { redirect_to post_path(@post, anchor: 'comments'), notice: I18n.translate('model_destroyed', name:I18n.translate('comment_definite')) }
      format.json { head :no_content }
    end
  end

  private

    def set_comment
      @comment = Comment.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def comment_params
      params.require(:comment).permit(:post_id, :body)
    end
end
