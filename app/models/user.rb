class User < ApplicationRecord
  has_many :user_videos
  has_many :videos, through: :user_videos

  has_many :friendships
  has_many :friended_users, through: :friendships

  has_many :inverse_friendships, class_name: 'Friendship', foreign_key: :friended_user_id
  has_many :users_who_friended, through: :inverse_friendships, source: :user

  validates :email, uniqueness: true, presence: true
  validates_presence_of :password_digest
  validates_presence_of :first_name
  enum role: %i[default admin]
  has_secure_password
end
