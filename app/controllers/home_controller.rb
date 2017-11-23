class HomeController < ApplicationController
  before_action :authenticate_user!, only: %i[favorites]

  def index
    @recipes = Recipe.all
    @cuisines = Cuisine.all
    @recipe_types = RecipeType.all
  end

  def favorites
    @favorite_recipes = current_user.favorites
  end
end
