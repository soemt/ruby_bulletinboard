json.extract! post, :id, :title, :description, :status, :created_user_id, :updated_user_id, :deleted_user_id, :created_at, :updated_at
json.url post_url(post, format: :json)
