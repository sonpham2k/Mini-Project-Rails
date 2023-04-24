class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.boolean :is_admin, :default => false
      t.string :password_digest
      t.string :reset_digest

      t.timestamps
      t.datetime :deleted_at
    end
  end
end
