class RecipesController < ApplicationController
  before_action :set_recipe, only: %i[show edit update destroy]
  before_action :authenticate_user!, except: %i[show index]
  before_action :recipe_own_by_user, only: %i[edit update destroy]

  def index
    @recipes = Recipe.where('title LIKE ?', "%#{params[:title]}%")
  end
  
  def show; end

  def new
    recipe_load
    @recipe = Recipe.new
  end

  def create
    @recipe = Recipe.new(recipe_params)
    @recipe.user = current_user
    if @recipe.save
      redirect_to @recipe
    else
      recipe_load
      render :new
    end
  end

  def edit
    recipe_load
  end

  def update
    if @recipe.update(recipe_params)
      redirect_to @recipe
    else
      recipe_load
      render :edit
    end
  end

  def destroy
    @recipe.destroy
    redirect_to root_path, alert: 'Receita apagada com sucesso.'
  end

  private

  def recipe_own_by_user
    return if @recipe.user == current_user
    redirect_to root_path, alert: 'Acesso Negado, você não é o '\
                                  'criador desta receita'
  end

  def set_recipe
    @recipe = Recipe.find(params[:id])
  end

  def recipe_params
    params.require(:recipe).permit(:title, :recipe_type_id,
                                   :cuisine_id, :difficulty,
                                   :cook_time, :ingredients,
                                   :cook_method)
  end

  def recipe_load
    @recipe_types = RecipeType.all
    @cuisines = Cuisine.all
  end
end
