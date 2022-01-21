class AddForeignKeys < ActiveRecord::Migration[7.0]
  def change
    add_foreign_key :users, :users, column: :created_user_id
    add_foreign_key :users, :users, column: :updated_user_id
  end
end
