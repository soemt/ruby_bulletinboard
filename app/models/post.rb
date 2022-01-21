class Post < ApplicationRecord
  belongs_to :created_user, class_name: "User", foreign_key: "created_user_id"
  belongs_to :updated_user, class_name: "User", foreign_key: "updated_user_id"

  include ExportCsv
  include ImportFile

  validates :title,
    presence: {
      message: "Title cannot be blank."
    },
    length: { 
      maximum: 255,
      too_long: "Title cannot be longer than %{count} characters." 
    }
  
  validates :description,
    presence: {
      message: "Description cannot be blank."
    }
  
  def self.search_post(keyword)
    if keyword.present?
      post = Post.where("lower (title) like :search or 
                         lower (description) like :search",
                         search: "%#{keyword.downcase}%")
      if post
        self.where(id: post)
      else
        Post.all
      end
    else
      Post.all
    end
  end

  def delete_post(id)
    self.deleted_user_id = id
    save!
  end

end
