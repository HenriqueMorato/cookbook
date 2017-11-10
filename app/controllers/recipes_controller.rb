class RecipesController < ApplicationController
  before_action :set_recipe, only: [:show]
  def show; end

  def new
    @recipe = Recipe.new
    @cuisines = Cuisine.all
    @recipe_types = RecipeType.all    
  end

  def create
    @recipe = Recipe.new(recipe_params)
    if @recipe.save
      redirect_to recipe_path @recipe
    else
      @cuisines = Cuisine.all
      @recipe_types = RecipeType.all
      render :new
    end
  end

  private

  def set_recipe
    @recipe = Recipe.find(params[:id])
  end

  def recipe_params
    params.require(:recipe).permit(:title, :recipe_type_id,
                                   :cuisine_id, :difficulty,
                                   :cook_time, :ingredients,
                                   :method)
  end
end
