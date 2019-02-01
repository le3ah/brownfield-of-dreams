class User < ApplicationRecord
  has_many :user_videos
  has_many :videos, through: :user_videos

  validates :email, uniqueness: true, presence: true
  validates_presence_of :password, if: :password
  validates_presence_of :first_name
  enum role: [:default, :admin]
  has_secure_password

  def self.from_omniauth(auth_info, current_user)
    current_user.update(uid: auth_info[:uid], oauth_token: auth_info[:credentials][:token])
    current_user
  end

end
