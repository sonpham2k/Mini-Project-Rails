class PostsController < ApplicationController
    layout 'homepages/master'

    def index
        @posts = Post.reorder("id DESC").paginate(page: params[:page], :per_page => 12)
    end

    def new
        @post = Post.new
    end

    def create
        begin
            result = []
            @post = Post.new post_params
            @post.user_id = current_user.id
            @messages = @post.valid_attributes?(:title)
            if @messages.none? && @post.save(:validate => false)
                params[:content].each do |post_content|
                    @content_list = {
                        post_id: @post.id,
                        content: post_content
                    }
                    result.push(@content_list)
                end
                if !@content_list.nil?
                    PostContent.create(result)
                end
                flash[:success] = "Add post success"
                return redirect_to posts_path
            end
            flash[:danger] = "Add post failed"
            return render 'new'
        rescue Exception => e
            logger.info e
        end
    end

    def edit
        @post = Post.find_by id: params[:id]
    end

    def update
        begin
            result = []
            items_remove = []
            @post = Post.find_by id: params[:id]
            @post.attributes = post_params
            @messages = @post.valid_attributes?(:title)
            if @messages.none? && @post.save(:validate => false)
                if !params[:content].nil?
                    params[:content].each do |post_content|
                        @content_list = {
                            post_id: @post.id,
                            content: post_content
                        }
                        result.push(@content_list)
                    end
                end
                if !@content_list.nil?
                    PostContent.create(result)
                end
                if !params[:post_remove_ids].nil?
                    params[:post_remove_ids].split(",").each do |post_remove_ids|
                        items_remove.push post_remove_ids
                    end
                end
                PostContent.destroy(items_remove)
                flash[:success] = "Update post success"
            end

            flash[:danger] = "Update post failed"
            return render 'edit'
        rescue Exception => e
            logger.info e
        end
    end

    def destroy
        begin
            @post = Post.includes(:post_contents).find_by(id: params[:id])
            @post_content_ids = @post.post_contents
            array = []
            @post_content_ids.each do |post_content|
                array.push post_content.id
            end
            PostContent.destroy(array)
            @post.delete
            flash[:success] = "Delete post success!"
            redirect_to posts_url
        rescue Exception => e
            logger.info e
        end
    end

    def show
        @post = Post.includes(:post_contents).find_by(id: params[:id])
        @user = User.includes(:result_votes).find_by(id: current_user.id)
    end

    private
    def post_params
        params.require(:post).permit :title
    end

    def post_content_params
        params.require(:post_content).permit :content[]
    end
end
