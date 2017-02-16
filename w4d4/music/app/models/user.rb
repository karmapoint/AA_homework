class User < ActiveRecord::Base
  validates :email, presence: true, uniqueness: true
  validates :password, length: { minimum: 6, allow_nil: true}

  attr_reader: :password
  after_initialization :reset_session_token!

  def self.find_by_credentials(email, password)
    @user = User.find_by(email)
    if @user
      Bcrypt::Password.new(self.password_digest).is_password?(password) ? @user : nil
    else
      flash[:email] << 'Invalid credentials'
    end
  end

  def self.generate_session_token
    self.session_token ||= SecureRandom.urlsafe_base64(16)
  end

  def reset_session_token!
    self.session_token ||= SecureRandom.urlsafe_base64(16)
  end

  def password=(password)
    @password = password
    self.password_digest = Bcrypt::Password.create(password)
  end

  def is_password?(password)
    Bcrypt::Password.new(password) == password
  end
end
