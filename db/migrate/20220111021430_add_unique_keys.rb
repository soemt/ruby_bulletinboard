class AddUniqueKeys < ActiveRecord::Migration[7.0]
  def change
    add_index :users, [:name, :email], unique: true
  end
end
