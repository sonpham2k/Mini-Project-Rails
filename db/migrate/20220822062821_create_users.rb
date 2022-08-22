class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.boolean :admin
      t.string :password_disgest
      t.string :reset_digest

      t.timestamps
      t.datetime :deleted_at
    end
  end
end
