class Recipe < ApplicationRecord
  belongs_to :cuisine
  belongs_to :recipe_type
  belongs_to :user
  has_many :favorite_recipes
  has_many :favorited_by, through: :favorite_recipes, source: :user

  validates :title, :recipe_type, :cuisine, :difficulty, :cook_time,
            :ingredients, :cook_method, presence: true

  has_attached_file :photo, styles: { main: '800x600>', smaill: '300x300>',
                                      thumb: '100x100>' },
                            default_url: '/assets/missing_:style.png'

  validates_attachment_content_type :photo, content_type: %r{\Aimage\/.*\z}

  def cook_time_min
    "#{cook_time} minutos"
  end
end
