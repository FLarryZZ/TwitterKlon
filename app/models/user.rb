class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :tweeets
  devise :omniauthable, omniauth_providers: %i[facebook]
  has_many :followers, foreign_key: "followed_id", class_name:"Relationship"
  has_many :following, foreign_key: "follower_id", class_name:"Relationship"
  def self.from_omniauth(auth)
  name_split = auth.info.name.split(" ")
  user = User.where(email: auth.info.email).first
  user ||= User.create!(provider: auth.provider, uid: auth.uid, name: name_split[0], username: name_split[1], email: auth.info.email, password: Devise.friendly_token[0, 20])
    user
end
end
