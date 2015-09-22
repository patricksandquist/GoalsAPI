# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  username        :string           not null
#  password_digest :string           not null
#  session_token   :string           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class User < ActiveRecord::Base
  validates :username, :password_digest, :session_token, presence: true
  validates :password, length: { minimum: 6, allow_nil: true }

  attr_reader :password

  after_initialize :ensure_token

  has_many :goals

  has_many(
    :comments,
    class_name: "UserComment",
    primary_key: :id,
    foreign_key: :user_id
  )

  has_many(
    :authored_comments,
    class_name: "UserComment",
    primary_key: :id,
    foreign_key: :author_id
  )

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end

  def reset_token!
    self.session_token = SecureRandom.urlsafe_base64
    self.save!
    self.session_token
  end

  def valid_password?(password)
    BCrypt::Password.new(self.password_digest).is_password?(password)
  end

  def self.find_by_credentials(username, password)
    user = User.find_by_username(username)
    return nil if user.nil?
    return user if user.valid_password?(password)
  end

  private

  def ensure_token
    self.session_token ||= SecureRandom.urlsafe_base64
  end
end
