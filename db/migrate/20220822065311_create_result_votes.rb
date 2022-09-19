class CreateResultVotes < ActiveRecord::Migration[5.2]
  def change
    create_table :result_votes do |t|
      t.integer :content_id
      t.integer :user_id

      t.timestamps
      t.datetime :deleted_at
    end
  end
end
