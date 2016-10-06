class User < ApplicationRecord
  validates :email, :session_token, :password_digest, presence: true
  validates :email, :session_token, uniqueness: true
  validates :password_digest, presence: { message: "Password can't be blank" }
  validates :session_token, presence: true, uniqueness: true
  before_validation :ensure_session_token

  attr_reader :password

  def self.generate_session_token
    SecureRandom::urlsafe_base64
  end

  def self.find_by_credentials(email, password)
    user = User.find_by_email(email)

  end

  def reset_session_token!
    @session_token = User.generate_session_token
    self.save
    @session_token
  end

  def ensure_session_token
    @session_token ||= User.generate_session_token
  end

  def password=(password)
    @password = password
    @password_digest = BCrypt::Password.create(password)
  end

  private
  def user_params
    params.require(:users).permit(:email, :session_token, :password_digest)
  end


end
