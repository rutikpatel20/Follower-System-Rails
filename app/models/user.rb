class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # Access the Relationship Object.
  has_many :followed_users,
           foreign_key: :follower_id,
           class_name: "Relationship",
           dependent: :destroy

  # Accesses the user through the relationship object.
  has_many :followees, through: :followed_users, dependent: :destroy

  # Access the Relationship Object.
  has_many :following_users,
           foreign_key: :followee_id,
           class_name: "Relationship",
           dependent: :destroy

  # Accesses the user through the relationship object.
  has_many :followers, through: :following_users, dependent: :destroy
end
