class CreateComments < ActiveRecord::Migration[5.2]
  def change
    create_table :comments do |t|
      t.integer :post_id
      t.integer :user_id
      t.string :content_comment

      t.timestamps
      t.datetime :deleted_at
    end
  end
end
