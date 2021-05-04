class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: [:google_oauth2]
  devise :omniauthable, omniauth_providers: %i[facebook]

         has_many :tweeets

         has_many :follower, foreign_key: "followed_id", class_name:"Relationship"
         has_many :following, foreign_key: "follower_id", class_name:"Relationship"

  def self.create_from_provider_data(provider_data)
    where(provider: provider_data.provider, uid: provider_data.uid).first_or_create do |user|
      user.email= provider_data.info.email
      user.password=Devise.friendly_token[0,20]
    end
  end

  def self.from_omniauth(auth)
  name_split = auth.info.name.split(" ")
  user = User.where(email: auth.info.email).first
  user ||= User.create!(provider: auth.provider, uid: auth.uid, last_name: name_split[0], first_name: name_split[1], email: auth.info.email, password: Devise.friendly_token[0, 20])
    user
end
end
