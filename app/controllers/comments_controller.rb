class CommentsController < ApplicationController
  include PostRepository

  layout "homepages/master"

  def create
    begin
      @post = repo.find(Post, params[:post_id])
      @comment = repo.new(Comment, comment_params)
      @comment.user_id = current_user.id
      repo.save(@comment)
      flash[:success] = "Add comment success!"
      return redirect_to post_path(@post)
    rescue Exception => e
      logger.info e
    end
  end

  def edit
    @comment = repo.find(Comment, params[:id])
  end

  def update
    begin
      @comment = repo.find(Comment, params[:id])
      @post = @comment.post
      @comment.attributes = content_comment_params
      repo.save(@comment)
      flash[:success] = "Edit comment success!"
      return redirect_to post_path(@post)
    rescue Exception => e
      logger.info e
    end
  end

  def destroy
    begin
      @comment = repo.find(Comment, params[:id])
      @post = @comment.post
      repo.delete(@comment)
      flash[:success] = "Delete comment success!"
      return redirect_to post_path(@post)
    rescue Exception => e
      logger.info e
    end
  end

  def show
  end

  private
  def comment_params
    params.permit :post_id, :content_comment
  end

  def content_comment_params
    params.permit :content_comment
  end

  def repo
    @repo ||= PostRepository.new
  end
end
