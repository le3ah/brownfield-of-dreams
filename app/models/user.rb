class User < ApplicationRecord
  has_many :user_videos
  has_many :videos, through: :user_videos
  has_many :friendships
  has_many :friends, through: :friendships

  validates :email, uniqueness: true, presence: true
  validates_presence_of :password, if: :password
  validates_presence_of :first_name
  enum role: [:default, :admin]
  has_secure_password

  # def from_omniauth(auth_info)
  #   update!(oauth_token: auth_info[:credentials][:token])
  #   update!(uid: auth_info[:uid])
  # end
end
