class CreatePostContents < ActiveRecord::Migration[5.2]
  def change
    create_table :post_contents do |t|
      t.integer :post_id
      t.string :answer
      t.string :content
      t.timestamps
      t.datetime :deleted_at
    end
  end
end
