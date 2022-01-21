json.extract! user, :id, :name, :email, :password, :profile, :role, :phone, :address, :dob, :created_user_id, :updated_user_id, :deleted_user_id, :created_at, :updated_at
json.url user_url(user, format: :json)
