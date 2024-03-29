class PostContentsController < ApplicationController
  layout "homepages/master"

  def update_post
    begin
      lists_vote = []
      results_vote = []
      results_unvote = []
      items_vote = []
      check = ""
      @post = Post.find_by id: params[:id]
      @user = User.includes(:result_votes).find_by(id: current_user.id)
      if !params[:post_vote_ids].nil?
        params[:post_vote_ids].split(",").each do |post_remove_ids|
          items_vote.push post_remove_ids
        end

        @user.result_votes.each do |user_vote|
          lists_vote.push user_vote.post_content_id
        end

        items_vote.each do |item_vote|
          check = (lists_vote.include? item_vote.to_i)
          if check
            @find = ResultVote.find_by user_id: current_user.id, post_content_id: item_vote
            results_unvote.push(@find.id)
          else
            @vote_list = {
              post_content_id: item_vote,
              user_id: current_user.id,
            }
            results_vote.push(@vote_list)
          end
        end
      end

      if !@vote_list.nil?
        ResultVote.create(results_vote)
      end
      if !results_unvote.empty?
        ResultVote.destroy(results_unvote)
      end
      flash[:success] = "Vote success"
      return redirect_to post_path
    rescue Exception => e
      logger.info e
    end
  end

  private

  def post_params
    params.require(:post).permit :title
  end
end
