class User < ApplicationRecord
  belongs_to :created_user, class_name: "User", foreign_key: "created_user_id"
  belongs_to :updated_user, class_name: "User", foreign_key: "updated_user_id"
  before_save :downcase_data

  has_secure_password
  mount_uploader :profile, ProfileUploader

  validates :name,
    presence: {
      message: "Name cannot be blank."
    },
    length: { 
      maximum: 255,
      too_long: "Name cannot be longer than %{count} characters." 
    },
    uniqueness: {
      case_sensitive: :false,
      message: "This name already exists."
    }

  validates :email,
    presence: {
      message: "Email cannot be blank."
    },
    length: { 
      maximum: 255,
      too_long: "Email cannot be longer than %{count} characters." 
    },
    uniqueness: {
      case_sensitive: :false,
      message: "This email already exists."
    },
    format: { 
      with: URI::MailTo::EMAIL_REGEXP,
      message: "Invalid email format." 
    }
  
  validates :password, 
    presence: {
      message: "Password cannot be blank."
    },
    length: { 
      minimum: 4,
      maximum: 8,
      too_short: "Password must at least have %{count} characters.", 
      too_long: "Password must be between %{count} characters." 
    },
    on: :create
  
  validates :phone,
    allow_blank: :true,
    numericality: {
      message: "Invalid characters. Phone must be numbers."
    },
    length: {
      minimum: 9,
      maximum: 12
    }

  def self.search_user(params)
    if params.present?
      user = User.where("lower (name) like ?", "%#{params[:name].to_s.downcase.gsub(/\s+/, '')}%")
                 .where("lower (email) like ?", "%#{params[:email].to_s.downcase.gsub(/\s+/, '')}%")

      if params[:start_date].present? && params[:end_date].present?
        user = User.where("lower (name) like ?", "%#{params[:name].to_s.downcase.gsub(/\s+/, '')}%")
                   .where("lower (email) like ?", "%#{params[:email].to_s.downcase.gsub(/\s+/, '')}%")
                   .where("created_at >= :start_date AND created_at <= :end_date",
                          {start_date: Time.parse(params[:start_date]).to_date.beginning_of_day, end_date: Time.parse(params[:end_date]).to_date.end_of_day})
      end

      if user
        self.where(id: user)
      else
        User.all
      end
    else 
      User.all
    end
  end

  def delete_user(id)
    self.deleted_user_id = id
    save!
  end

  def generate_password_token!
    self.reset_password_token = generate_token
    self.reset_password_sent_at = Time.now.utc
    save!
    PasswordMailer.reset(self).deliver_now
  end
  
  def password_token_valid?
    (self.reset_password_sent_at + 4.hours) > Time.now.utc
  end
  
  def reset_password!(password)
    self.reset_password_token = nil
    self.password = password
    save!
  end

  def to_param
    name
  end

  def downcase_data
    self.email.downcase!
  end
  
  private
  def generate_token
    SecureRandom.hex(10)
  end
end
