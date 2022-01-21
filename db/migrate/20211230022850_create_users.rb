class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :name, null: false, unique: true
      t.string :email, null: false, unique: true
      t.string :password, null: false
      t.string :profile, null: false
      t.string :role, null: false
      t.string :phone
      t.string :address
      t.date :dob
      t.bigint :created_user_id, null: false
      t.bigint :updated_user_id, null: false
      t.integer :deleted_user_id

      t.timestamps
    end
  end
end
