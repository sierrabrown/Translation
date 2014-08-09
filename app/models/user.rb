class User < ActiveRecord::Base
  validates :username, :password_digest, :email, presence: true
  validates :password, length: { minimum: 6, allow_nil: true }
  validates :email, uniqueness: true, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i, on: :create }
  validates :username, uniqueness: true
  attr_reader :password
  
  has_many :jobs, foreign_key: :customer_id, class_name: "Job"
  has_many :tasks, foreign_key: :translator_id, class_name: "Task"
  
  def reset_token!
    self.token = SecureRandom.urlsafe_base64(16)
    self.save!
    self.token
  end
  

  def self.find_by_credentials(username, password)
    user = User.find_by(username: username)
    return nil unless user && user.valid_password?(password)
    user
  end

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end

  def valid_password?(password)
    BCrypt::Password.new(self.password_digest).is_password?(password)
  end
  
  def chargeCard(params)
    debugger
  end
  
end
