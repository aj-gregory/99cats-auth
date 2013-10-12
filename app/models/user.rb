class User < ActiveRecord::Base
  attr_accessible :password, :user_name, :session_token
  attr_reader :password

  before_validation(on: :create) do
    set_session_token! if session_token.nil?
  end

  validates :user_name, :session_token, :presence => true
  validates :user_name, :uniqueness => true
  validates :password, :length => { :minimum => 6, :allow_nil => true}

  has_many :cats, :dependent => :destroy

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end

  def is_password?(password)
    BCrypt::Password.new(self.password_digest).is_password?(password)
  end

  def set_session_token!
    self.session_token = SecureRandom.urlsafe_base64
    self.session_token
  end

  def reset_session_token!
    self.session_token = SecureRandom.urlsafe_base64
    self.save
    self.session_token
  end

  def self.find_by_credentials(user_name, password)
    u = User.find_by_user_name(user_name)
    return u if u && u.is_password?(password)
    nil
  end

end
