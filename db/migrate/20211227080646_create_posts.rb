class CreatePosts < ActiveRecord::Migration[7.0]
  def change
    create_table :posts do |t|
      t.string :title, null: false
      t.string :description, null: false
      t.integer :status, null: false
      t.bigint :created_user_id, null: false
      t.bigint :updated_user_id, null: false
      t.integer :deleted_user_id

      t.timestamps
    end
  end
end
