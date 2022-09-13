class CommentsController < ApplicationController
  layout "homepages/master"

  def index
  end

  def new
  end

  def create
    begin
      @post = Post.includes(:comments).find_by(id: params[:post_id])
      @comment = Comment.new comment_params
      @comment.user_id = current_user.id
      @comment.save
      flash[:success] = "Add comment success!"
      return redirect_to post_path(@post)
    rescue Exception => e
      logger.info e
    end
  end

  def edit
    @comment = Comment.find(params[:id])
  end

  def update
    begin
      @comment = Comment.find_by id: params[:id]
      @post = @comment.post
      @comment.attributes = content_comment_params
      @comment.save
      flash[:success] = "Edit comment success!"
      return redirect_to post_path(@post)
    rescue Exception => e
      logger.info e
    end
  end

  def destroy
    begin
      @comment = Comment.includes(:post).find(params[:id])
      @post = @comment.post
      @comment.delete
      flash[:success] = "Delete comment success!"
      return redirect_to post_path(@post)
    rescue Exception => e
      logger.info e
    end
  end

  def show
  end

  def update_post
  end

  private

  def comment_params
    params.permit :post_id, :content_comment
  end

  def content_comment_params
    params.permit :content_comment
  end
end
