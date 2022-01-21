class UpdateForm 
  include ActiveModel::Model

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

  attr_accessor :id, :title, :description, :status, :updated_user_id
  class << self
      def initialize(params)
          {
              :id => params.id,
              :title => params.title,
              :description => params.description,
              :status => params.status,
              :updated_user_id => params.updated_user_id
          }
      end        
  end
end