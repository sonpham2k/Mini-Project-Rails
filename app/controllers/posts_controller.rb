class PostsController < ApplicationController
  include PostRepository
  include PostContentRepository

  layout "homepages/master"

  def index
    @q = Post.ransack(params[:q])
    @posts = @q.result.page(params[:page])
  end

  def new
    @post = repoPost.new(Post, nil)
  end

  def create
    begin
      result = []
      @post = repoPost.new(Post, post_params)
      @post.user_id = current_user.id
      @messages = repoPost.validate_attr(@post, :title)
      if @messages.none? && repoPost.save_not_validate(@post)
        params[:content].each do |post_content|
          @content_list = {
            post_id: @post.id,
            content: post_content,
          }
          result.push(@content_list)
        end
        if !@content_list.nil?
          repoPostContent.create(PostContent, result)
        end
        flash[:success] = "Add post success"
        return redirect_to posts_path
      end
      flash[:error] = "Add post failed"
      return render "new"
    rescue Exception => e
      logger.info e
    end
  end

  def edit
    @post = repoPost.find(Post, params[:id])
  end

  def update
    begin
      result = []
      items_remove = []
      @post = repoPost.find(Post, params[:id])
      @post.attributes = post_params
      if @post.save
        if !params[:content].nil?
          params[:content].each do |post_content|
            @content_list = {
              post_id: @post.id,
              content: post_content,
            }
            result.push(@content_list)
          end
        end
        if !@content_list.nil?
          repoPostContent.create(PostContent, result)
        end
        if !params[:post_remove_ids].nil?
          params[:post_remove_ids].split(",").each do |post_remove_ids|
            items_remove.push post_remove_ids
          end
        end
        repoPostContent.delete(PostContent, items_remove)
        flash[:success] = "Update post success"
      end

      flash[:error] = "Update post failed"
      return render "edit"
    rescue Exception => e
      logger.info e
    end
  end

  def destroy
    begin
      @post = repoPost.find(Post, params[:id])
      @post_content_ids = @post.post_contents
      array = []
      @post_content_ids.each do |post_content|
        array.push post_content.id
      end
      repoPostContent.delete(PostContent, array)
      repoPost.delete(@post)
      flash[:success] = "Delete post success!"
      redirect_to posts_url
    rescue Exception => e
      logger.info e
    end
  end

  def show
    @post = repoPost.find(Post, params[:id])
    @user = repoPost.find(User, current_user.id)
  end

  private

  def post_params
    params.require(:post).permit :title
  end

  def post_content_params
    params.require(:post_content).permit :content[]
  end

  def repoPost
    @repoPost ||= PostRepository.new
  end

  def repoPostContent
    @repoPostContent ||= PostContentRepository.new
  end
end
