class RenameContentIdToResultVotes < ActiveRecord::Migration[5.2]
  def change
    rename_column :result_votes, :content_id, :post_content_id
  end
end
