class Recipe < ApplicationRecord
  belongs_to :cuisine
  belongs_to :recipe_type
end
