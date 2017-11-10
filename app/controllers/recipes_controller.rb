class RecipesController < ApplicationController
  before_action :set_recipe, only: %i[show edit update]
  def show; end

  def new
    recipe_eager_load
    @recipe = Recipe.new
  end

  def create
    @recipe = Recipe.new(recipe_params)
    if @recipe.save
      redirect_to @recipe
    else
      recipe_eager_load
      render :new
    end
  end

  def edit
    recipe_eager_load
  end

  def update
    if @recipe.update(recipe_params)
      redirect_to @recipe
    else
      recipe_eager_load
      render :edit
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
                                   :cook_method)
  end

  def recipe_eager_load
    @recipe_types = RecipeType.all
    @cuisines = Cuisine.all
  end
end
