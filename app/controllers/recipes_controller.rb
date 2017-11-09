class RecipesController < ApplicationController
  before_action :set_recipe, only: [:show]
  def show; end

  def new
    @recipe = Recipe.new
  end

  def create
    @recipe = Recipe.new(recipe_params)
    if @recipe.save
      redirect_to recipe_path @recipe
    else
      render :new
    end
  end

  private

  def set_recipe
    @recipe = Recipe.find(params[:id])
  end

  def recipe_params
    params.require(:recipe).permit(:title, :recipe_type,
                                   :cuisine, :difficulty,
                                   :cook_time, :ingredients,
                                   :method)
  end
end
