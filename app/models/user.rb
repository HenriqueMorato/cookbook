class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  enum role: { user: 0, admin: 1 }

  has_many :recipes
  has_many :favorite_recipes
  has_many :favorites, through: :favorite_recipes, source: :recipe
end
